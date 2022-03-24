# Scenarios usecase for oci volume clone, volume backup, custom image

## Custom Image
You can use custome image in any one of these 2 scenarios
* If you are planing to migrate a onprem vm to oci, note the onprem vm image shoud be of vmdk format for import.
* You can create a custom Image with all dependencies installed and make the as a golden image or template for provissing new instances, Note the hostnames need to be mannually changed after provission or use custom init to change the hostname or user terraform remote exec provisioner of ansible code.  

Note what ever be the way if you take volume clone or volume backup and restore or custome image for creating new instance, the custom hostname (manuall way: advance options to to set custom hostname in network tab) will not be assigned to the newly created instances.

[GitHub Logo](/images/github-logo.png)

1. Before you create a custom image of an instance, you must disconnect all iSCSI attachments and remove all iscsid node configurations from the instance.  
2. When you create an image of a running instance, the instance shuts down and remains unavailable for several minutes. The instance restarts when the process 
completes.  
3. You can’t create more than one custom image of a single instance at a time. When you start to create a custom image, the system implements a 20-minute timeout during which you can’t create another image of the same instance. You can, however, create images of different instances at the same time.  
4. You can import or export a custom image with a maximum size of 400 GB.  

https://blogs.oracle.com/developers/post/working-with-oracle-cloud-infrastructure-custom-compute-images
