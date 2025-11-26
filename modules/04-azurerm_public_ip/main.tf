resource "azurerm_public_ip" "child_public_ip" {
  for_each = var.var_child_public_ip
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

