module "prod" {
  source                       = "./modules"
  instance_availability_domain = var.instance_availability_domain
  tenancy_ocid                 = var.tenancy_ocid
  instance_display_name        = var.instance_display_name
  instance_shape               = var.instance_shape
  instance_memory_in_gbs       = var.instance_memory_in_gbs
  instance_ocpus               = var.instance_ocpus
  instance_subnetId            = var.instance_subnetId
  instance_hostname            = var.instance_hostname
  instance_imageid             = var.instance_imageid
  ssh_authorized_keys_file     = var.ssh_authorized_keys_file
}
