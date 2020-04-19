#1.==================================================
# Configure the VMware vCloud Director Provider - Start
provider "vcd" {
  user                 = "${var.vcd_username}"
  password             = "${var.vcd_password}"
  org                  = "${var.vcd_system_org}"
  url                  = "${var.vcd_url}"
  max_retry_timeout    = "${var.vcd_max_retry_timeout}"
  allow_unverified_ssl = "${var.vcd_allow_unverified_ssl}"
}
# Configure the VMware vCloud Director Provider End
#==================================================


#2.==================================================
# Create a New Organisation only - Start
resource "vcd_org" "org-name"{
  name = "${var.client_name}"
  full_name = "${var.client_full_name}"
  description = "${var.client_description}"
  stored_vm_quota = "${var.stored_vm_quota}"
  deployed_vm_quota = "${var.deployed_vm_quota}"
vapp_lease {
    maximum_runtime_lease_in_sec          = 0
    power_off_on_runtime_lease_expiration = false
    maximum_storage_lease_in_sec          = 0
    delete_on_storage_lease_expiration    = false
  }
  vapp_template_lease {
    maximum_storage_lease_in_sec       = 0
    delete_on_storage_lease_expiration = false
  }
  is_enabled = "${var.is_enabled}"
  delete_recursive = "${var.delete_recursive}"
  delete_force = "${var.delete_force}"
}
# Create a New Organisation only - End
#==================================================

#3.==================================================
#Create a new External Network for "Sandeep-Terra" - Start
resource "vcd_external_network" "EXT-NW-Sandeep-Terra" {
  name        = "${var.network-name}"
  description = "${var.network-description}"
  vsphere_network {
    vcenter = "${var.vcenter}" #VC name registered in vCD
    name    = "${var.vsphere-network-name}"
    type    = "${var.vsphere-network-type}"
  }
  ip_scope {
    gateway    = "${var.gateway}"
    netmask    = "${var.netmask}"
    dns1       = "${var.dns1}"
    dns2       = "${var.dns2}"
    dns_suffix = "${var.dns_suffix}"
    static_ip_pool {
      start_address = "${var.static_start_address}"
      end_address   = "${var.static_end_address}"
    }
  }
  retain_net_info_across_deployments = "${var.retain_net_info_across_deployments}"
}
#Create a new External Network for "Sandeep-Terra" - End
#==================================================


#4.=============================================================
# Create a new Organization Admin  - Start
resource "vcd_org_user" "sandeep-admin" {
  org               = "${var.client_org}"
  name              = "${var.client_admin_user}"
  password          = "${var.client_admin_password}"
  role              = "${var.client_user_role}"
  enabled           = "true"
  take_ownership    = "true"
  provider_type     = "${var.provider_type}" 
  stored_vm_quota   = "${var.stored_vm_quota}"
  deployed_vm_quota = "${var.deployed_vm_quota}"
}
# Create a new Organization Admin  - End
# ==============================================================

#5.===============================================================================================
# Create Org VDC for above organisation - Start
resource "vcd_org_vdc" "Sandeep-PVDC" {
  name = "${var.org_vdc_name}"
  org  = "${var.client_vdc_org}"
  allocation_model  = "${var.client_allocation_model}"
  provider_vdc_name = "${var.client_providervdc_name}"
  network_pool_name = "${var.client_network_pool_name}"
  network_quota     = 5
  compute_capacity {
    cpu {
      limit = 0
    }
    memory {
      limit = 0
    }
  }
  storage_profile {
    name    = "*"
    enabled = true
    limit   = 0
    default = true
  }
  enabled                  = true
  enable_thin_provisioning = true
  enable_fast_provisioning = true
  delete_force             = true
  delete_recursive         = true
}
# Create Org VDC for above organisation - End
# ===============================================================================================

#6.===============================================================================================
# Create Org VDC Edge for above org VDC - Start
resource "vcd_edgegateway" "Sandeep-Terra-Edge-T01" {
  org                     = "${var.client_vdc_org}"
  vdc                     = "${var.org_vdc_name}"
  name                    = "${var.edge_name}"
  description             = "${var.edge_description}"
  configuration           = "${var.edge_configuration}"
  advanced                = "${var.edge_advanced}"
  external_network {
     name = "${var.edge_ext_name}"
     subnet {
        ip_address            = "${var.edge_ip_address}"
        gateway               = "${var.edge_ip_gateway}"
        netmask               = "${var.edge_ip_netmask}"
        use_for_default_route = true
    }
  }
}
# Create Org VDC Edge for above org VDC - End
# ===============================================================================================


/* #6.===============================================================================================
# Create Org VDC Edge for above org VDC with auto IP - Start
resource "vcd_edgegateway" "Sandeep-Terra-Edge-T02" {
  org                     = "${var.client_vdc_org}"
  vdc                     = "${var.org_vdc_name}"
  name                    = "${var.edge_name1}"
  description             = "${var.edge_description1}"
  configuration           = "${var.edge_configuration1}"
  advanced                = "${var.edge_advanced1}"
  default_gateway_network = "${var.edge_ext_name1}"
  external_networks        = ["${var.edge_ext_name1}"]
  
  /* external_network {
     name = "${var.edge_ext_name1}"
     
     subnet {
        ip_address            = "${var.edge_ip_address1}"
        gateway               = "${var.edge_ip_gateway1}"
        netmask               = "${var.edge_ip_netmask1}"
        use_for_default_route = true
    }
  }
}
# Create Org VDC Edge for above org VDC - End
# ===============================================================================================
*/

#7.===============================================================================================
# Create Routed Network for this org - Start
resource "vcd_network_routed" "Sandeep-Terra-Routed-01" {
  name         = "${var.routed_edge_network_name}"
  org          = "${var.client_vdc_org}"
  vdc          = "${var.org_vdc_name}"
  # This is name of Edge gateway below
  edge_gateway = "${var.edge_name}"
  description = "${var.routed_edge_network_description}"
  gateway      = "${var.routed_edge_gateway}"
  static_ip_pool {
    start_address = "${var.routed_edge_start_address}"
    end_address   = "${var.routed_edge_end_address}"
  }
}
# Create Routed Network for this org  - End
# ===============================================================================================

#8.===============================================================================================
# Create Isolated Network for org - Start
resource "vcd_network_isolated" "Sandeep-Terra-Isolated-01" {
  name         = "${var.isolated_edge_network_name}"
  org          = "${var.client_vdc_org}"
  vdc          = "${var.org_vdc_name}"
  # This is name of Edge gateway below
  description = "${var.isolated_edge_network_description}"
  gateway      = "${var.isolated_edge_gateway}"
  static_ip_pool {
    start_address = "${var.isolated_edge_start_address}"
    end_address   = "${var.isolated_edge_end_address}"
  }
}
#Create Isolated Network for org - End
# ===============================================================================================

#9.===============================================================================================
# Create Direct Network for this org - Start
resource "vcd_network_direct" "Sandeep-Terra-direct-01" {
  name             = "${var.direct_edge_network_name}"
  org              = "${var.client_vdc_org}"
  vdc              = "${var.org_vdc_name}"
  external_network = "${var.direct_ext_network_name}"
}
# Create Direct Network for this org - End
# ===============================================================================================

#10.=====================================================
# Create Default catalog for org - Start
resource "vcd_catalog" "ISO-Files-Sandeep-Terra" {
  org         = "${var.client_vdc_org}"
  name        = "${var.catalog_name}"
  description = "${var.catalog_description}"
  delete_force     = "true"
  delete_recursive = "true"
  /*depends_on       = "${var.catalog_depends_on}"*/
}
# Create Default catalog for org - End
#=====================================================

/*#11.=====================================================
#This is working but taking too much time to upload
# Create Default catalog item for this org Start
resource "vcd_catalog_media" "CentOS" {
  org                 = "${var.client_vdc_org}"
  catalog              = "${var.catalog_name}"
  name                 = "${var.catalog_item_name}"
  description          = "${var.catalog_item_description}"
  media_path           = "${var.catalog_item_media_path}"
  upload_piece_size    = "${var.catalog_item_upload_piece_size}"
  show_upload_progress = "true"
}
# Create Default catalog item for this org End
#=====================================================*/

#12.=====================================================
# Create vApp for org - Start
resource "vcd_vapp" "vapp-Sandeep-Terra" {
  name             = "${var.vapp_name}"
  org              = "${var.client_vdc_org}"
  vdc              = "${var.org_vdc_name}"
  description      = "${var.vapp_description}"
  # This dependency is must to avoid a lock during destroy
  /*depends_on = [vcd_network_routed.net-tfcloud-r]*/
}
# Create vApp for org - End
#=====================================================

#13.=====================================================
# Create or Adding VM to vapp - Start
resource "vcd_vapp_vm" "VAPP-VM-Web-01" {
  name         = "${var.catalog_vapp_vm_name}"
  org          = "${var.client_vdc_org}"
  vdc          = "${var.org_vdc_name}"
  vapp_name    = "${var.vapp_name}"
  catalog_name = "${var.catalog_name}"
  template_name = "${var.catalog_vapp_vm_template}"
  cpus = "${var.catalog_vapp_vm_cpus}"
  memory = "${var.catalog_vapp_vm_memory}"
  network {
    name               = "${var.routed_edge_network_name}"
    type               = "${var.catalog_vapp_vm_type}"
    ip_allocation_mode = "${var.catalog_ip_allocation_mode}"
  }
}
# Create or Adding VM to vapp - End
#=====================================================