resource "azurerm_mssql_server" "child_azure_mssql_server" {
  for_each = var.var_child_sqlserver

  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = data.azurerm_key_vault_secret.get_key_vault_secret_sqlserver_username_1[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.get_key_vault_secret_sqlserver_password_1[each.key].value

  minimum_tls_version           = each.value.minimum_tls_version
  public_network_access_enabled = each.value.public_network_access_enabled

  identity {
    type = each.value.identity.type
  }
}


resource "azurerm_mssql_firewall_rule" "allow_my_ip" {
  depends_on = [azurerm_mssql_server.child_azure_mssql_server]
  for_each   = var.var_child_sqlserver

  name             = "AllowMyHomeIP"
  server_id        = data.azurerm_mssql_server.get_child_sql_server_1[each.key].id
  start_ip_address = data.external.get_my_ip.result.public_ip
  end_ip_address   = data.external.get_my_ip.result.public_ip
}


