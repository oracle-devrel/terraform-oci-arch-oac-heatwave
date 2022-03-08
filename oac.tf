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
        whitelisted_ips = var.analytics_whitelisted_ips
        whitelisted_vcns {
            id = oci_core_virtual_network.oac_heatwave_vcn.id
        }
    }
    defined_tags = {"${oci_identity_tag_namespace.ArchitectureCenterTagNamespace.name}.${oci_identity_tag.ArchitectureCenterTag.name}" = var.release }
}

resource "oci_analytics_analytics_instance_private_access_channel" "oac_for_heatwave_private_access_channel" {
    analytics_instance_id = oci_analytics_analytics_instance.oac_for_heatwave.id
    display_name = "oac4heatwave_pac"
    private_source_dns_zones {
        dns_zone = "oachwvcn.oraclevcn.com"
        description = "Access to MDS from OAC"
    }
    subnet_id = oci_core_subnet.oac_db_subnet.id
    vcn_id = oci_core_virtual_network.oac_heatwave_vcn.id
}