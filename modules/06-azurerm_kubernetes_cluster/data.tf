data "azurerm_subnet" "get_child_subnet_k8s" {
  for_each = var.var_child_kubernetes_cluster
  
  name                 = each.value.default_node_pool.vnet_subnet_name_k8s
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.default_node_pool.vnet_k8s_name
}

data "azurerm_application_gateway" "get_child_application_gateway" {
  for_each = var.var_child_kubernetes_cluster
  
  name                = each.value.ingress_application_gateway.gateway_name
  resource_group_name = each.value.resource_group_name
}