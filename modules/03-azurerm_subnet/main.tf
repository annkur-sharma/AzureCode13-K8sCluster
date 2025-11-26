resource "azurerm_subnet" "subnet" {
  for_each = var.var_child_subnet
  
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  # Required for Application Gateway as Enabled
  private_endpoint_network_policies = each.value.private_endpoint_network_policies
}

