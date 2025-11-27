variable "var_child_sqlserver" {
  type = map(object(
    {
      name                          = string
      resource_group_name           = string
      location                      = string
      version                       = string
      minimum_tls_version           = string
      public_network_access_enabled = bool

      identity = object(
        {
          type = string
        }
      )

      # For username and password
      key_Vault_name                = string
      key_Value_resource_group_name = string
      key_sqlserver_username        = string
      key_sqlserver_password        = string
    }
  ))
}
