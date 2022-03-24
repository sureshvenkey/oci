# Scenarios usecase for oci volume clone, volume backup, custom image

## Custom Image
You can use custome image in any one of these 2 scenarios
* If you are pllaning to migrate a onprem vm to oci, note the onprem vm image shoud be of vmdk format  

1. Before you create a custom image of an instance, you must disconnect all iSCSI attachments and remove all iscsid node configurations from the instance.  
2. When you create an image of a running instance, the instance shuts down and remains unavailable for several minutes. The instance restarts when the process 
completes.  
3. You can’t create more than one custom image of a single instance at a time. When you start to create a custom image, the system implements a 20-minute timeout during which you can’t create another image of the same instance. You can, however, create images of different instances at the same time.  
4. You can import or export a custom image with a maximum size of 400 GB.  
