variable "root_provider_subscription_id" {
  type = string
}

variable "var_root_resource_group" {
  description = "The details of the resource group"
  type = map(object(
    {
      resource_group_name = string
      resource_location   = string
    }
  ))
}

variable "var_root_vnet" {
  type = map(object(
    {
      vnet_name           = string
      address_space       = list(string)
      location            = string
      resource_group_name = string
    }
  ))
}

variable "var_root_subnet" {
  type = map(object(
    {
      subnet_name                       = string
      resource_group_name               = string
      address_prefixes                  = list(string)
      virtual_network_name              = string
      private_endpoint_network_policies = optional(string)
    }
  ))
}

variable "var_root_public_ip" {
  type = map(object(
    {
      public_ip_name      = string
      resource_group_name = string
      location            = string
      allocation_method   = string
      sku                 = string
    }
  ))
}

variable "var_root_kubernetes_cluster" {
  description = "The details of the K8s Cluster"
  type = map(object(
    {
      resource_group_name  = string
      resource_location    = string
      k8s_cluster_name     = string
      k8s_cluster_dns_name = string

      kubernetes_version = optional(string)

      default_node_pool = object({
        name                 = string
        node_count           = number
        vm_size              = string
        vnet_subnet_name_k8s = string
        vnet_k8s_name        = string
        max_pods             = number
        type                 = string
      })

      identity = object({
        type = string
      })

      # AGIC Addon – Linking AKS to Application Gateway
      ingress_application_gateway = object({
        gateway_id   = optional(string)
        gateway_name = optional(string)
        # subnet_id    = optional(string)
        # subnet_cidr  = optional(list(string))
      })

      network_profile = object({
        network_plugin      = string
        network_plugin_mode = string
        network_policy      = string
        load_balancer_sku   = string
      })
    }
  ))
}

variable "var_root_application_gateway" {
  type = map(object(
    {
      appgateway_name     = string
      resource_group_name = string
      location            = string

      sku = object({
        name     = string
        tier     = string
        capacity = number
      })

      gateway_ip_configuration = object({
        name              = string
        appgw_subnet_name = string
        vnet_name         = string

      })

      frontend_port = object({
        name = string
        port = number
      })

      frontend_ip_configuration = object({
        name                          = string
        public_ip_address_app_gw_name = string
      })

      backend_address_pool = object({
        name = string
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

variable "var_root_acr" {
  type = map(object(
    {
      acr_data = object(
        {
          acr_name            = string
          resource_group_name = string
          location            = string
          sku                 = string
        }
      )

      acr_role_assignment = object(
        {
          principal_id_k8s_name            = string
          role_definition_name             = string
          scope                            = string
          skip_service_principal_aad_check = bool
        }
      )
    }
  ))
}

variable "var_root_sqlserver" {
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

variable "var_root_sql_database" {
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
