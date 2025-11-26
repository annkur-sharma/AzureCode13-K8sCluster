data "azurerm_kubernetes_cluster" "get_child_kubernetes_cluster" {
  for_each = var.var_child_acr
  
  name                = each.value.acr_role_assignment.principal_id_k8s_name
  resource_group_name = each.value.acr_data.resource_group_name
}