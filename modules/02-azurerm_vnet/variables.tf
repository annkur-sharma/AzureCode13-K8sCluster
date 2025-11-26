variable "var_child_vnet" {
  type = map(object(
    {
      vnet_name                = string
      address_space       = list(string)
      location            = string
      resource_group_name = string
    }
  ))
}