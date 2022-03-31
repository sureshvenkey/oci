# terraform.tfvars file is used to set the actual values of the variables.
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
# Display Name
instance_display_name = "Linux101-dev"
# Name of the Shape
instance_shape = "VM.Standard.A1.Flex"
# Memory in GB
instance_memory_in_gbs = "6"
# opcus count
instance_ocpus = "2"
# Description for the user
instance_availability_domain = "ZJPZ:UK-LONDON-1-AD-1"
# OCID of the subnet
instance_subnetId = "ocid1.subnet.oc1.uk-london-1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
# OCID of the Image
instance_imageid = "ocid1.image.oc1.uk-london-1.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
# Hostname of the instance
instance_hostname = "Linux101-dev"
#Public key location. if windows specify the path as \\
ssh_authorized_keys_file = "C:\\Users\\EICPL02L126\\Desktop\\Linux\\keys\\oci.pub"
