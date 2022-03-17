
## Use OCI fn function to load data from object server to Autonomus Database 
Useful link for ETL using Oracle Functions
The below link uses soda to connect to Autonmous Databse, but insted i use cx_Oracle python module to connect to Autonmous Database  
https://docs.oracle.com/en/learn/functions_adw/index.html#introduction  
Commonly used code in Oracle Functions  
https://github.com/oracle/oracle-functions-samples/tree/master/samples  

1. I use fnproject/python:3.8 and fnproject/python:3.8-dev docker images of RHEL8 flavour to run functions in container.    
2. Download the latest Oracle instant client libraries and make sure they are copied in the container. I used instantclient_21_5 (instantclient-basic-linux.x64-21.5.0.0.0dbru) which can be downloded from https://www.oracle.com/database/technologies/instant-client/downloads.html for more details refer Dockerfile.  
3. If you need to add additional packages to be included in the conatiner, then create Dockerfile. 
Use the fn build command with verbose to know the Dockerfile which is used.
> fn -v build
4. In some cases you might require the libaio.sp.1 library which does'nt come with instant client whcih may need to be installed manually. Use rpm command to install libaio-0.3.112-1.el8.x86_64.rpm package to resolve the dependency.  
