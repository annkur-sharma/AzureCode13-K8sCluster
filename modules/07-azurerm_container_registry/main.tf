resource "azurerm_container_registry" "child_azure_container_registry" {
  for_each = var.var_child_acr

  name                = each.value.acr_data.acr_name
  resource_group_name = each.value.acr_data.resource_group_name
  location            = each.value.acr_data.location
  sku                 = each.value.acr_data.sku
}

resource "azurerm_role_assignment" "child_azure_container_registry_role_assignment" {
  for_each = var.var_child_acr
  
  principal_id                     = data.azurerm_kubernetes_cluster.get_child_kubernetes_cluster[each.key].kubelet_identity[0].object_id
  role_definition_name             = each.value.acr_role_assignment.role_definition_name
  scope                            = azurerm_container_registry.child_azure_container_registry[each.key].id
  skip_service_principal_aad_check = each.value.acr_role_assignment.skip_service_principal_aad_check
}