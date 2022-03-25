## Copyright (c) 2022 Oracle and/or its affiliates.
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

module "magento" {
  source                    = "github.com/oracle-devrel/terraform-oci-arch-magento"
  tenancy_ocid              = var.tenancy_ocid
  vcn_id                    = oci_core_virtual_network.oac_heatwave_vcn.id
  numberOfNodes             = 1
  availability_domain_name  = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availability_domain_name
  compartment_ocid          = var.compartment_ocid
  image_id                  = lookup(data.oci_core_images.InstanceImageOCID.images[0], "id")
  shape                     = var.node_shape
  label_prefix              = var.label_prefix
  ssh_authorized_keys       = var.ssh_public_key
  mds_ip                    = module.mds-heatwave-instance.mysql_db_system.ip_address
  magento_subnet_id         = oci_core_subnet.magento_subnet.id
  admin_password            = var.admin_password
  admin_username            = var.admin_username
  magento_schema            = var.magento_schema
  magento_name              = var.magento_name
  magento_password          = var.magento_password
  magento_admin_password    = var.magento_admin_password
  magento_admin_email       = var.magento_admin_email
  magento_backend_frontname = var.magento_backend_frontname
  display_name              = var.magento_instance_name
  flex_shape_ocpus          = var.node_flex_shape_ocpus
  flex_shape_memory         = var.node_flex_shape_memory
  defined_tags              = { "${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}