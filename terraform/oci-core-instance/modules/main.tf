resource "oci_core_instance" "this" {
    #Required
	availability_domain = "${var.instance_availability_domain}"
    compartment_id = "${var.tenancy_ocid}"
	display_name = "${var.instance_display_name}"
	
    shape = "${var.instance_shape}"
	shape_config {
        #Required if flexible shape
        memory_in_gbs = "${var.instance_memory_in_gbs}"
        ocpus = "${var.instance_ocpus}"
    }
	create_vnic_details {
		#Required
		subnet_id = "${var.instance_subnetId}"
		#Optional
		hostname_label = "${var.instance_hostname}"
	}
	source_details {
        #Required
        source_id = "${var.instance_imageid}"
		source_type = "image"
    }
	
	metadata = {
    ssh_authorized_keys = file(var.ssh_authorized_keys_file)
	}
	preserve_boot_volume = false
}
