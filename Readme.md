# OCI Fn Function as Serverless Service 
The Fn project is an open-source container-native serverless platform that you can run anywhere any cloud or on-premise.  
It’s easy to use, supports every programming language, and is extensible and performant.  
> https://fnproject.io/  
> https://docs.oracle.com/en-us/iaas/Content/Functions/Concepts/functionsoverview.html  

If you are new to fn function, then start with fn init command which creates a function boilerplate (Starting point).
> $ fn init --runtime python pythonfn  
> $ cd pythonfn  
> $ ls  
> func.py func.yaml requirements.txt  
> $ cat func.py  
> ```import io  
> import json  
> from fdk import response  
> def handler(ctx, data: io.BytesIO=None):  
>    name = "World"  
>    try:  
>        body = json.loads(data.getvalue())  
>        name = body.get("name")  
>    except (Exception, ValueError) as ex:  
>        print(str(ex))  
>    return response.Response(  
>        ctx, response_data=json.dumps(  
>            {"message": "Hello {0}".format(name)}),  
>        headers={"Content-Type": "application/json"}  
>    )  ```  

https://fnproject.io/tutorials/python/intro/


# Use OCI fn function to load data from object storage to Autonomus Database with cx_Oracle python module
https://github.com/sureshvenkey/oci/tree/main/fn-functions/oci-load-file-into-adw-python
