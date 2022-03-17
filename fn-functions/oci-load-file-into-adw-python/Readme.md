
## Use OCI fn function to load data from object storage to Autonomus Database using cx_Oracle python module
Useful link for ETL using Oracle Functions  
The below link uses soda to connect to Autonmous Databse, but insted i use cx_Oracle python module to connect to Autonmous Database  
https://docs.oracle.com/en/learn/functions_adw/index.html#introduction  
Commonly used code in Oracle Functions  
https://github.com/oracle/oracle-functions-samples/tree/master/samples  


> #### End User or IOT Device ---> OCI Bucket ---> OCI Event ---> OCI FN-Function ---> Autonomous Database  
 

1. I use fnproject/python:3.8 and fnproject/python:3.8-dev docker images of RHEL8 flavour to run functions in container.    
3. Download the latest Oracle instant client libraries and make sure they are copied in the container. I used instantclient_21_5 (instantclient-basic-linux.x64-21.5.0.0.0dbru) which can be downloded from https://www.oracle.com/database/technologies/instant-client/downloads.html for more details refer Dockerfile.  
4. If you need to add additional packages to be included in the conatiner, then create Dockerfile. 
Use the fn build command with verbose to know the Dockerfile which is used.
> fn -v build
4. In some cases you might require the libaio.sp.1 library which does'nt come with instant client which may need to be installed manually. Use rpm command to install libaio-0.3.112-1.el8.x86_64.rpm package to resolve the dependency.  
5. The required python modules need to be specified in requirements.txt file. I have added the cx_Oracle module init.
6. Workaround for "libclntsh.so: file too short" error
> "SystemExit: DPI-1047: Cannot locate a 64-bit Oracle Client library: \"/function/instantclient_21_5/libclntsh.so: file too short\". See https://cx-oracle.readthedocs.io/en/latest/user_guide/installation.html for help"  
If the libclntsh.so file is an empty file copy the libclntsh.so.21.1 file with libclntsh.so file.  
> cp libclntsh.so.21.1 libclntsh.so
