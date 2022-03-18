
## Use OCI fn function to load data from object storage to Autonomus Database with cx_Oracle python module
Useful link for ETL using Oracle Functions  
The below link uses soda to connect to Autonmous Databse, but insted i use cx_Oracle python module to connect to Autonmous Database  
https://docs.oracle.com/en/learn/functions_adw/index.html#introduction  
Commonly used code in Oracle Functions  
https://github.com/oracle/oracle-functions-samples/tree/master/samples  


> #### End User or IOT Device ---> OCI Bucket ---> OCI Event ---> OCI FN-Function ---> Autonomous Database  
 

1. I use fnproject/python:3.8 and fnproject/python:3.8-dev docker images of RHEL8 flavour to run functions in container.    
3. Download the latest Oracle instant client libraries and make sure they are copied in the container. I used instantclient_21_5 (instantclient-basic-linux.x64-21.5.0.0.0dbru) which can be downloded from https://www.oracle.com/database/technologies/instant-client/downloads.html for more details refer Dockerfile.  
4. During build or deploy phase of the function, Oracle Functions uses the “func.yaml” file to create a temporary Dockerfile to build the Docker image. Once the docker image is created Oracle Functions deletes this file.  
If you need to add additional packages to be included in the conatiner, then create a Dockerfile simillar to the Dockerfile created by fn function using “func.yaml”, then to add the dependencies using COPY or ADD command.   
Use the fn build command with verbose to know the Dockerfile used by fn function.
> fn -v build

Sample Dockerfile is given below

> FROM fnproject/python:3.8-dev as build-stage  
> WORKDIR /function  
> ADD requirements.txt /function/  
> ** ADD libaio-0.3.112-1.el8.x86_64.rpm /function/ **  
> ** COPY instantclient_21_5 /function/ **
> ** RUN rpm -ivh /function/libaio-0.3.112-1.el8.x86_64.rpm **  
> RUN pip3 install --target /python/  --no-cache --no-cache-dir -r requirements.txt && rm -fr ~/.cache/pip /tmp* requirements.txt func.yaml Dockerfile .venv && chmod -R o+r /python  
> ADD . /function/  
> RUN rm -fr /function/.pip_cache  
> FROM fnproject/python:3.8  
> WORKDIR /function  
> COPY --from=build-stage /python /python   
> COPY --from=build-stage /function /function  
> RUN chmod -R o+r /function  
> ## ENV PYTHONPATH=/function:/python  
> ENV LD_LIBRARY_PATH /function/instantclient_21_5  
> ENTRYPOINT ["/python/bin/fdk", "/function/func_ora.py", "handler"]  

For more detail about adding dependency packages at runtime, refer:
> https://ofmwtech.wordpress.com/2022/01/11/using-external-jars-in-oci-functions-with-runtime-as-java/  
> https://docs.oracle.com/en-us/iaas/Content/Functions/Tasks/functionsusingcustomdockerfiles.htm

4. In case if you need libaio.sp.1 library which does'nt come with instant client, Use rpm command to install libaio-0.3.112-1.el8.x86_64.rpm package to resolve the dependency.  
5. The required python modules need to be specified in requirements.txt file. I have added the cx_Oracle module init.
6. Workaround for "libclntsh.so: file too short" error
> "SystemExit: DPI-1047: Cannot locate a 64-bit Oracle Client library: \"/function/instantclient_21_5/libclntsh.so: file too short\". See https://cx-oracle.readthedocs.io/en/latest/user_guide/installation.html for help"    

If the libclntsh.so is an empty file copy the libclntsh.so.21.1 with libclntsh.so file.   
cp libclntsh.so.21.1 libclntsh.so

## Aditional Resource  
> Developer Tutorial  
> https://docs.oracle.com/en-us/iaas/developer-tutorials/tutorials/home.htm#home__functions
