resource "azurerm_application_gateway" "child_application_gateway" {
  for_each = var.var_child_application_gateway
  
  name                = each.value.appgateway_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = each.value.sku.name
    tier     = each.value.sku.tier
    capacity = each.value.sku.capacity
  }

  gateway_ip_configuration {
    name      = each.value.gateway_ip_configuration.name
    subnet_id = data.azurerm_subnet.get_child_subnet_id_appgateway[each.key].id
  }

  frontend_port {
    name = each.value.frontend_port.name
    port = each.value.frontend_port.port
  }

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration.name
    public_ip_address_id = data.azurerm_public_ip.get_child_public_ip_appgateway[each.key].id
  }

  backend_address_pool {
    name = each.value.backend_address_pool.name
  }

  backend_http_settings {
    name                  = each.value.backend_http_settings.name
    cookie_based_affinity = each.value.backend_http_settings.cookie_based_affinity
    path                  = each.value.backend_http_settings.path
    port                  = each.value.backend_http_settings.port
    protocol              = each.value.backend_http_settings.protocol
    request_timeout       = each.value.backend_http_settings.request_timeout
  }

  http_listener {
    name                           = each.value.http_listener.name
    frontend_ip_configuration_name = each.value.http_listener.frontend_ip_configuration_name
    frontend_port_name             = each.value.http_listener.frontend_port_name
    protocol                       = each.value.http_listener.protocol
    host_name                      = each.value.http_listener.host_name
  }

  request_routing_rule {
    name                       = each.value.request_routing_rule.name
    priority                   = each.value.request_routing_rule.priority
    rule_type                  = each.value.request_routing_rule.rule_type
    http_listener_name         = each.value.request_routing_rule.http_listener_name
    backend_address_pool_name  = each.value.request_routing_rule.backend_address_pool_name
    backend_http_settings_name = each.value.request_routing_rule.backend_http_settings_name
  }
}