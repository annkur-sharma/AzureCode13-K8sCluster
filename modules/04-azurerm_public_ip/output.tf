# output "child_output_public_IP" {
#   description = "App Gateway: Public IP: "
#   value = azurerm_public_ip.child_public_ip[each.key].ip_address
# }