#
# oci load csv file into autonmous database using python version 1.0.
# Uses cx_Oracle module for autonmous database connection
# Install the necessary oracle client libraries and place the autonmous database wallet zip file under the oracle client location
# 

import io
import json
import oci
import csv
import requests
import cx_Oracle

from fdk import response
  
def load_data(signer, namespace, bucket_name, object_name, dbdns, dbencoding, dbuser, dbpwd):
    client = oci.object_storage.ObjectStorageClient(config={}, signer=signer)
    connection = None
    try:
        # cx_Oracle.init_oracle_client(lib_dir="/function/instantclient_21_5")
        # Create a database connection to ADP
        connection = cx_Oracle.connect(dbuser,dbpwd,dbdns,encoding=dbencoding)
        print("Database Version "+connection.version)
        # Ceates a cursor for inserting the data into the database
        cursor = connection.cursor()
        print("INFO - About to read object {0} in bucket {1}...".format(object_name, bucket_name), flush=True)
        # we assume the file can fit in memory, otherwise we have to use the "range" argument and loop through the file
        csvdata = client.get_object(namespace, bucket_name, object_name)
        if csvdata.status == 200:
            print("INFO - Object {0} is read".format(object_name), flush=True)
            input_csv_text = str(csvdata.data.text)
            reader = csv.reader(input_csv_text.split('\n'), delimiter=',')
            for row in reader:
                print("INFO - inserting:")
                cursor.execute("insert into MYTABLE(region, col1, col2, col3) values (:1, :2, :3, :4)", (row[0], row[1], row[2], row[3]))
                print(row)
        else:
            raise SystemExit("cannot retrieve the object" + str(object_name))
        connection.commit()
        cursor.close()
    except Exception as e:
        raise SystemExit(str(e))
        print("INFO - All documents are successfully loaded into the database", flush=True)
    finally:
        # release the connection
        if connection:
            connection.close()


def handler(ctx, data: io.BytesIO=None):
    signer = oci.auth.signers.get_resource_principals_signer()
    object_name = bucket_name = namespace = dbdns = encoding = dbuser = dbpwd = ""
    try:
        cfg = ctx.Config()
        input_bucket = cfg["input-bucket"]
        dbdns = cfg["db-dns"]
        dbuser = cfg["db-user"]
        dbpwd = cfg["db-passwdcipher"]
        encoding = cfg["db-encoding"]
    except Exception as e:
        print('Missing function parameters: bucket_name, dbdns, encoding, dbuser, dbpwd', flush=True)
        raise
    try:
        body = json.loads(data.getvalue())
        print("INFO - Event ID {} received".format(body["eventID"]), flush=True)
        print("INFO - Object name: " + body["data"]["resourceName"], flush=True)
        object_name = body["data"]["resourceName"]
        print("INFO - Bucket name: " + body["data"]["additionalDetails"]["bucketName"], flush=True)
        if body["data"]["additionalDetails"]["bucketName"] != input_bucket:
            raise ValueError("Event Bucket name error")
        print("INFO - Namespace: " + body["data"]["additionalDetails"]["namespace"], flush=True)
        namespace = body["data"]["additionalDetails"]["namespace"]
    except Exception as e:
        print('ERROR: bad Event!', flush=True)
        raise
    load_data(signer, namespace, input_bucket, object_name, dbdns, encoding, dbuser, dbpwd)

    return response.Response(
        ctx, 
        response_data=json.dumps({"status": "Success"}),
        headers={"Content-Type": "application/json"}
    )
