resource "azurerm_virtual_network" "child_vnet" {
  for_each = var.var_child_vnet
  
  name                = each.value.vnet_name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  
}


