variable "var_child_subnet" {
  type = map(object(
    {
      subnet_name          = string
      resource_group_name  = string
      address_prefixes     = list(string)
      virtual_network_name = string

      private_endpoint_network_policies = optional(string)
    }
  ))
}
