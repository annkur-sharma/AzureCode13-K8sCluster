resource "null_resource" "set_execution_policy" {
  provisioner "local-exec" {
    command = "powershell -Command \"Set-ExecutionPolicy Bypass -Scope Process -Force\""
  }
}

data "external" "get_my_ip" {
  depends_on = [null_resource.set_execution_policy]
  program    = ["powershell", "-File", "${path.module}/../../infra/scripts/get_ip.ps1"] #for Windows
  #   program = ["bash", "${path.module}/get_ip.sh"] # or ["pwsh", "${path.module}/get_ip.ps1"] for Windows
}

data "azurerm_mssql_server" "get_child_sql_server_1" {
  depends_on          = [azurerm_mssql_server.child_azure_mssql_server]
  for_each = var.var_child_sqlserver
  
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault" "get_azure_key_vault_1" {
  for_each = var.var_child_sqlserver

  name                = each.value.key_Vault_name
  resource_group_name = each.value.key_Value_resource_group_name
}

data "azurerm_key_vault_secret" "get_key_vault_secret_sqlserver_username_1" {
  for_each = var.var_child_sqlserver

  name         = each.value.key_sqlserver_username
  key_vault_id = data.azurerm_key_vault.get_azure_key_vault_1[each.key].id
}

data "azurerm_key_vault_secret" "get_key_vault_secret_sqlserver_password_1" {
  for_each = var.var_child_sqlserver

  name         = each.value.key_sqlserver_password
  key_vault_id = data.azurerm_key_vault.get_azure_key_vault_1[each.key].id
}


