# Scenarios usecase for oci volume clone, volume backup, custom image

1. Before you create a custom image of an instance, you must disconnect all iSCSI attachments and remove all iscsid node configurations from the instance.  
2. When you create an image of a running instance, the instance shuts down and remains unavailable for several minutes. The instance restarts when the process 
completes.  
3. You can’t create more than one custom image of a single instance at a time. When you start to create a custom image, the system implements a 20-minute timeout during which you can’t create another image of the same instance. You can, however, create images of different instances at the same time.  
