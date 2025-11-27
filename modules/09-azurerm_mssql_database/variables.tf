variable "var_child_sql_database" {
  type = map(object(
    {
      name                = string
      collation           = string
      license_type        = string
      max_size_gb         = number
      sku_name            = string
      enclave_type        = string
      sql_server_name     = string
      resource_group_name = string
    }
  ))
}
