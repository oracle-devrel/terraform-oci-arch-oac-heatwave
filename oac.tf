## Copyright (c) 2022, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_analytics_analytics_instance" "oac_for_heatwave" {
    compartment_id    = var.compartment_ocid
    feature_set       = var.analytics_instance_feature_set
    license_type      = var.analytics_instance_license_type
    name              = var.analytics_instance_name
    description       = "oac_for_heatwave"
    idcs_access_token = var.analytics_instance_idcs_access_token
    capacity {
        capacity_type  = var.analytics_instance_capacity_capacity_type
        capacity_value = var.analytics_instance_capacity_capacity_value
    }
    network_endpoint_details {
        network_endpoint_type = "PUBLIC"
        whitelisted_vcns {
            id = oci_core_virtual_network.oac_heatwave_vcn.id
            whitelisted_ips = var.analytics_whitelisted_ips
        }
    }
    defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}
