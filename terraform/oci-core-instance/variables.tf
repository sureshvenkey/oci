# variables.tf file is used to define the variables type and optionally set a default value.

variable "instance_availability_domain" {
  type        = string
  description = "Name of the availability_domain"
  nullable    = false
}
variable "instance_display_name" {
  type        = string
  description = "Display Name"
  nullable    = false
}
variable "instance_imageid" {
  type        = string
  description = "OCID of the imageid"
  nullable    = false
}
variable "instance_shape" {
  type        = string
  description = "Name of the shape"
  nullable    = false
}
variable "instance_memory_in_gbs" {
  type        = string
  description = "instance_shape_config Memory in gbs"
  nullable    = false
}
variable "instance_ocpus" {
  type        = string
  description = "instance_shape_config ocpus"
  nullable    = false
}
variable "instance_subnetId" {
  type        = string
  description = "OCID of the subnetid"
  nullable    = false
}
variable "instance_hostname" {
  type        = string
  description = "Name of the hostname"
  nullable    = false
}
variable "tenancy_ocid" {
  type        = string
  description = "Tenancu OCID"
  nullable    = false
}
variable "ssh_authorized_keys_file" {
  type        = string
  description = "publickey location"
  nullable    = false
  sensitive   = true
}
