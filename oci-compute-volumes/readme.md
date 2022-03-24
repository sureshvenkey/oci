# Usecase for oci volume clone, volume backup, custom image

* Use custom image if you are planing to migrate a onprem vm to oci, note the onprem vm image shoud be of vmdk format for import.
* You can create a custom Image with all dependencies installed and make the as a golden image or template for provissing new instances, Note the hostnames need to be mannually changed after provission or use custom init to change the hostname or user terraform remote exec provisioner of ansible code. 
* Backup & Restore are sutable for standard schedulled backup process which can be taken either incremental for full backups. Note the restore creates the volume from the backup stored in object storage which migh take some time for restor deponding up on the size.
* volume clone are always full backup, can be used in emergency condition.   

Note what ever be the way if you take volume clone or volume backup and restore or custome image for creating new windows instance, the custom hostname (manuall way: advance options to to set custom hostname in network tab) will not be assigned to the newly created instances. But it works for linux.

[hostname_under_networking](/images/hostname.JPG)

1. Before you create a custom image of an instance, you must disconnect all iSCSI attachments and remove all iscsid node configurations from the instance.  
2. When you create an image of a running instance, the instance shuts down and remains unavailable for several minutes. The instance restarts when the process 
completes.  
3. You can’t create more than one custom image of a single instance at a time. When you start to create a custom image, the system implements a 20-minute timeout during which you can’t create another image of the same instance. You can, however, create images of different instances at the same time.  
4. You can import or export a custom image with a maximum size of 400 GB.  
5. A cloned volume is a point-in-time direct disk-to-disk deep copy of the source volume. All data on the source volume is copied to the clone volume. Cloning enables you to make a copy of an existing boot or block volume without going through the backup and restore process.
6. Boot and block volume backups are a point-in-time backup of data to Object Storage, which can be either full or incremental.  

https://blogs.oracle.com/developers/post/working-with-oracle-cloud-infrastructure-custom-compute-images  

https://database-heartbeat.com/2020/12/31/three-ways-to-clone-your-compute-instance-in-oracle-cloud-infrastructure/#:~:text=%20Three%20Ways%20to%20Clone%20your%20Compute%20Instance,duplicate%20an%20instance%20in%20the%20same...%20More%20   
