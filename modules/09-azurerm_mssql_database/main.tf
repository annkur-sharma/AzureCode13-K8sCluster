resource "azurerm_mssql_database" "example" {
  for_each = var.var_child_sql_database
  
  name         = each.value.name
  server_id    = data.azurerm_mssql_server.get_child_sql_server[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type
}




