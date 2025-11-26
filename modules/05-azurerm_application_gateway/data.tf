data "azurerm_subnet" "get_child_subnet_id_appgateway" {
  for_each = var.var_child_application_gateway

  name                 = each.value.gateway_ip_configuration.appgw_subnet_name
  virtual_network_name = each.value.gateway_ip_configuration.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "get_child_public_ip_appgateway" {
  for_each = var.var_child_application_gateway
  
  name                = each.value.frontend_ip_configuration.public_ip_address_app_gw_name
  resource_group_name = each.value.resource_group_name
}

# data "azurerm_network_interface" "get_child_vm1_nic1" {
#   name                = "acctest-nic"
#   resource_group_name = var.child_resource_group_name
# }

# data "azurerm_network_interface" "get_child_vm2_nic2" {
#   name                = "acctest-nic"
#   resource_group_name = var.child_resource_group_name
# }