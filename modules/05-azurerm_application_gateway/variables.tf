variable "var_child_application_gateway" {
  type = map(object(
    {
      appgateway_name                = string
      resource_group_name = string
      location            = string

      sku = object({
        name     = string
        tier     = string
        capacity = number
      })

      gateway_ip_configuration = object({
        name      = string
        appgw_subnet_name = string
        vnet_name = string
      })

      frontend_port = object({
        name = string
        port = number
      })

      frontend_ip_configuration = object({
        name                 = string
        public_ip_address_app_gw_name = string
      })

      backend_address_pool = object({
        name         = string
      })

      backend_http_settings = object({
        name                  = string
        cookie_based_affinity = string
        path                  = string
        port                  = number
        protocol              = string
        request_timeout       = number
      })

      http_listener = object({
        name                           = string
        frontend_ip_configuration_name = string
        frontend_port_name             = string
        protocol                       = string
        host_name                      = string
      })

      request_routing_rule = object({
        name                       = string
        priority                   = number
        rule_type                  = string
        http_listener_name         = string
        backend_address_pool_name  = string
        backend_http_settings_name = string
      })
    }
  ))
}
