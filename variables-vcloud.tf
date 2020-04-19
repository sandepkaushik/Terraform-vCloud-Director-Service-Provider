#1.=====================================================
# Variable for all the Login details - Start
variable "vcd_username" {type = string}
variable "vcd_password" {type = string}
variable "vcd_url" {}
variable "vcd_max_retry_timeout" {}       
variable "vcd_system_org" {type = string}
variable "vcd_allow_unverified_ssl" {default = true}
variable "vcenter" {type = string}
# Variable for all the Login details - End
#=====================================================

#2.=====================================================
# Variable for Configure client organisation - Start
variable "client_name" {type = string}
variable "client_full_name" {type = string}
variable "client_description" {type = string}
variable "is_enabled" {}
variable "delete_recursive" {type = string}
variable "delete_force" {type = string}
variable "stored_vm_quota" {}
variable "deployed_vm_quota" {}
# Variable for Configure client organisation - End
#=====================================================

#3.=====================================================
# Variable for External network for client  - Start
variable "network-name" {type = string}
variable "network-description" {type = string}
variable "vsphere-network-name" {type = string}
variable "vsphere-network-type" {type = string}
variable "gateway" {}
variable "netmask" {}
variable "dns1" {}
variable "dns2" {}
variable "dns_suffix" {}
variable "static_start_address" {}
variable "static_end_address" {}
variable "retain_net_info_across_deployments" {}
# Variable for External network for client - End
#=====================================================


#4.=====================================================
# Variable for new Organization Username - Start
variable "client_org" {} 
variable "client_admin_user" {}
variable "client_admin_password" {}
variable "client_user_role" {}
variable "enabled" {type = string}
variable "take_ownership" {type = string}
variable "provider_type" {type = string} 
# Variable for new Organization Username - End
#=====================================================

#5.=====================================================
# Variable for org-VDC for client - Start
variable "org_vdc_name" {} 
variable "client_vdc_org" {}
variable "client_allocation_model" {}
variable "client_providervdc_name" {}
variable "client_network_pool_name" {}
variable "client_network_quota" {}
# Variable for org-VDC for client - End
#=====================================================

#6.=====================================================
# Variable for Edge Gateway - Start
variable "edge_name" {} 
variable "edge_description" {}
variable "edge_configuration" {}
variable "edge_advanced" {}
variable "edge_ext_name" {}
variable "edge_ip_address" {}
variable "edge_ip_gateway" {}
variable "edge_ip_netmask" {}
variable "edge_use_for_default_route" {}
# Variable for Edge Gateway - End
#=====================================================

#6.=====================================================
# Variable for Edge Gateway auto ip - Start
variable "edge_name1" {} 
variable "edge_description1" {}
variable "edge_configuration1" {}
variable "edge_advanced1" {}
variable "edge_ext_name1" { type = string}
variable "edge_ip_address1" {}
variable "edge_ip_gateway1" {}
variable "edge_ip_netmask1" {}
# Variable for Edge Gateway auto ip - End
#=====================================================

#7.=====================================================
#Variable for Edge Routed Network - Start
variable "routed_edge_gateway" {} 
variable "routed_edge_start_address" {}
variable "routed_edge_end_address" {}
variable "routed_edge_network_name" {}
variable "routed_edge_network_description" {}
#Variable for Edge Routed Network - End
#=====================================================

#8.=====================================================
#Variable for Edge Isolated Network - Start
variable "isolated_edge_gateway" {} 
variable "isolated_edge_start_address" {}
variable "isolated_edge_end_address" {}
variable "isolated_edge_network_name" {}
variable "isolated_edge_network_description" {}
#Variable for Edge Isolated Network - End
#=====================================================

#9.=====================================================
#Variable for Edge direct Network - Start
variable "direct_edge_network_name" {}
variable "direct_edge_gateway" {}
variable "direct_edge_start_address" {} 
variable "direct_edge_end_address" {} 
variable "direct_edge_network_description" {}
variable "direct_ext_network_name" {}
#Variable for Edge direct Network - End
#=====================================================

#10.=====================================================
#Variable  catalog for org - Start
variable "catalog_name"        {}
variable "catalog_description" {}
variable "catalog_delete_force"    {}
variable "catalog_delete_recursive" {}
variable "catalog_depends_on" {}
#Variable  catalog for org - End
#=====================================================

#11.=====================================================
# variable Default catalog item for org - Start
variable "catalog_item_name" {}
variable "catalog_item_description" {}
variable "catalog_item_media_path" {}
variable "catalog_item_upload_piece_size" {}
variable "catalog_item_show_upload_progress" {}
# variable Default catalog item for org - End
#=====================================================

#12.=====================================================
#Variable  vapp for org - Start
variable "vapp_name"        {}
variable "vapp_description" {}
#Variable  vapp for org - End
#=====================================================

#13.=====================================================
# Variable catalog vapp adding VM for org vapp vm - Start
variable "catalog_vapp_vm_name" {}
variable "catalog_vapp_vm_cpus" {}
variable "catalog_vapp_vm_memory" {}
variable "catalog_vapp_vm_type" {}
variable "catalog_vapp_vm_template" {}
variable "catalog_ip_allocation_mode" {}
# Variable catalog vapp adding VM for org vapp vm - End
#===================================================== */


