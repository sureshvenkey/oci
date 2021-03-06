
## Use OCI fn function to load data from object storage to Autonomous Database with cx_Oracle python module
Useful link for ETL using Oracle Functions  
The below link uses soda to connect to Autonomous Databse, but insted i use cx_Oracle python module to connect to Autonmous Database  
https://docs.oracle.com/en/learn/functions_adw/index.html#introduction  
Commonly used code in Oracle Functions  
https://github.com/oracle/oracle-functions-samples/tree/master/samples  

**Function Flow**  
> ```#### Function Flow   
> 
> #### End User or IOT Device ---> OCI Bucket ---> OCI Event ---> OCI FN-Function ---> Autonomous Database
> ```  
 

1. I use fnproject/python:3.8 and fnproject/python:3.8-dev docker images of RHEL8 flavour to run functions in container.    
3. Download the latest Oracle instant client libraries and make sure they are copied in the container. I used instantclient_21_5 (instantclient-basic-linux.x64-21.5.0.0.0dbru) which can be downloded from https://www.oracle.com/database/technologies/instant-client/downloads.html for more details refer Dockerfile.  
4. During build or deploy phase of the function, Oracle Functions uses the “func.yaml” file to create a temporary Dockerfile to build the Docker image. Once the docker image is created Oracle Functions deletes this file.  
If you need to add additional packages to be included in the conatiner, then create a Dockerfile simillar to the Dockerfile created by fn function using “func.yaml”, then to add the dependencies using COPY or ADD command. The required python modules need to be specified in requirements.txt file. I have added the cx_Oracle module in it.  
Use the fn build command with verbose to know the Dockerfile used by fn function.
> fn -v build

Sample Dockerfile is given below

> FROM fnproject/python:3.8-dev as build-stage  
> WORKDIR /function  
> ADD requirements.txt /function/  
> **ADD libaio-0.3.112-1.el8.x86_64.rpm /function/    
> COPY instantclient_21_5 /function/  
> RUN rpm -ivh /function/libaio-0.3.112-1.el8.x86_64.rpm**  
> RUN pip3 install --target /python/  --no-cache --no-cache-dir -r requirements.txt && rm -fr ~/.cache/pip /tmp* requirements.txt func.yaml Dockerfile .venv && chmod -R o+r /python  
> ADD . /function/  
> RUN rm -fr /function/.pip_cache  
> FROM fnproject/python:3.8  
> WORKDIR /function  
> COPY --from=build-stage /python /python   
> COPY --from=build-stage /function /function  
> RUN chmod -R o+r /function  
> ENV PYTHONPATH=/function:/python&      
> **ENV LD_LIBRARY_PATH /function/instantclient_21_5**    
> ENTRYPOINT ["/python/bin/fdk", "/function/func_ora.py", "handler"]  

For more detail about adding dependency packages at runtime, refer:
> https://ofmwtech.wordpress.com/2022/01/11/using-external-jars-in-oci-functions-with-runtime-as-java/  
> https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionsusingcustomdockerfiles.htm

4. In case if you need libaio.sp.1 library which does'nt come with instant client, Use rpm command to install libaio-0.3.112-1.el8.x86_64.rpm package to resolve the dependency.  
5. Autonomous Database uses mtls (mutual tls) authentication that means you need to have the Wallet zip in addition to the database password to connect to the database.

The zip file will be in Wallet_databasename.zip format and includes the following files:  
- tnsnames.ora and sqlnet.ora: Network configuration files storing connect descriptors and SQL*Net client side configuration.  
- cwallet.sso and ewallet.p12: Auto-open SSO wallet and PKCS12 file. The PKCS12 file is protected by the wallet password provided while downloading the wallet.  
- keystore.jks and truststore.jks: Java keystore and truststore files. They are protected by the wallet password provided while downloading the wallet.  
- ojdbc.properties: Contains the wallet related connection property required for JDBC connection. This should be in the same path as tnsnames.ora.  
- README: Contains wallet expiration information and links for Autonomous Database tools and resources.  

The zip file contents need to be extracted under LD_LIBRARY_PATH/network/admin directory, i.e. copy it under our working directory having the oracle instaclient. We have set the LD_LIBRARY_PATH environment variable in Dockerfile as  
> "ENV LD_LIBRARY_PATH /function/instantclient_21_5"  

Refer below link for more details  
> https://docs.oracle.com/en/cloud/paas/autonomous-data-warehouse-cloud/cswgs/autonomous-connect-download-credentials.html#GUID-B06202D2-0597-41AA-9481-3B174F75D4B1  
> https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/connect-download-wallet.html#GUID-BE884A1B-034D-4CD6-9B71-83A4CCFDE9FB  
> https://docs.oracle.com/en/cloud/paas/autonomous-database/adbsa/connecting-nodejs.html#GUID-AB1E323A-65B9-47C4-840B-EC3453F3AD53  

6. Workaround for "libclntsh.so: file too short" error
> "SystemExit: DPI-1047: Cannot locate a 64-bit Oracle Client library: \"/function/instantclient_21_5/libclntsh.so: file too short\". See https://cx-oracle.readthedocs.io/en/latest/user_guide/installation.html for help"    

If the libclntsh.so is an empty file copy the libclntsh.so.21.1 with libclntsh.so file.   
cp libclntsh.so.21.1 libclntsh.so

## Aditional Resource  
> Developer Tutorial  
> https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/home.htm#home__functions
