# output "child_output_child_kubernetes_cluster" {
#   description = "K8s Cluster Name: "
#   value = azurerm_kubernetes_cluster.child_kubernetes_cluster[each.key].name
# }