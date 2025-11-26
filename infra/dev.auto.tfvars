root_provider_subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

var_root_resource_group = {
  rg_1 = {
    resource_group_name = "rg1k8s"
    resource_location   = "francecentral"
  }
}

var_root_vnet = {
  vnet_1 = {
    vnet_name           = "rg1k8s-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = "francecentral"
    resource_group_name = "rg1k8s"
  }
}

var_root_subnet = {
  subnet_1_K8s = {
    subnet_name                       = "rg1k8s-subnet-k8s"
    resource_group_name               = "rg1k8s"
    address_prefixes                  = ["10.0.2.0/24"]
    virtual_network_name              = "rg1k8s-vnet"
    private_endpoint_network_policies = "Disabled"
  }
  subnet_2_apgw = {
    subnet_name                       = "rg1k8s-subnet-apgw"
    resource_group_name               = "rg1k8s"
    address_prefixes                  = ["10.0.1.0/24"]
    virtual_network_name              = "rg1k8s-vnet"
    private_endpoint_network_policies = "Enabled"
  }
}

var_root_public_ip = {
  public_ip_1 = {
    public_ip_name      = "rg1k8s-pip-apgw"
    resource_group_name = "rg1k8s"
    location            = "francecentral"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

var_root_kubernetes_cluster = {
  k8s_cluster_1 = {
    resource_group_name  = "rg1k8s"
    resource_location    = "francecentral"
    k8s_cluster_name     = "rg1k8s-k8s"
    k8s_cluster_dns_name = "rg1k8s-k8s-dns"

    default_node_pool = {
      name                 = "nodepool"
      node_count           = 2
      vm_size              = "Standard_D2ds_v4"
      vnet_subnet_name_k8s = "rg1k8s-subnet-k8s"
      vnet_k8s_name        = "rg1k8s-vnet"
      max_pods             = 100
      type                 = "VirtualMachineScaleSets"
    }

    identity = {
      type = "SystemAssigned"
    }

    # AGIC Addon – Linking AKS to Application Gateway
    ingress_application_gateway = {
      gateway_name = "rg1k8s-apgw"
    }

    network_profile = {
      network_plugin      = "azure"    # ✅ Enables Azure CNI networking. # Azure CNI (integrated with VNet)
      network_plugin_mode = "overlay"  # ✅ Enables Azure CNI with overlay mode # Uses internal IP overlay, saves VNet IPs
      network_policy      = "calico"   # ✅ Allows use of Calico for network policy enforcement #  Calico for fine-grained network policies
      load_balancer_sku   = "standard" # ✅ Enterprise-grade Azure Load Balancer
    }
  }
}

var_root_application_gateway = {
  application_gateway_1 = {
    appgateway_name     = "rg1k8s-apgw"
    resource_group_name = "rg1k8s"
    location            = "francecentral"

    sku = {
      name     = "Standard_v2"
      tier     = "Standard_v2"
      capacity = 2
    }

    gateway_ip_configuration = {
      name              = "rg1k8s-apgw-ip-config-1"
      appgw_subnet_name = "rg1k8s-subnet-apgw"
      vnet_name         = "rg1k8s-vnet"
    }

    frontend_port = {
      name = "rg1k8s-apgw-fe-port-1"
      port = 80
    }

    frontend_ip_configuration = {
      name                          = "rg1k8s-apgw-fe-ipcfg-1"
      public_ip_address_app_gw_name = "rg1k8s-pip-apgw"
    }

    backend_address_pool = {
      name = "rg1k8s-apgw-be-pool-1"
    }

    backend_http_settings = {
      name                  = "rg1k8s-apgw-be-http-set-1"
      cookie_based_affinity = "Disabled"
      path                  = "/"
      port                  = 80
      protocol              = "Http"
      request_timeout       = 60
    }

    http_listener = {
      name                           = "rg1k8s-apgw-http-listen-1"
      frontend_ip_configuration_name = "rg1k8s-apgw-fe-ipcfg-1"
      frontend_port_name             = "rg1k8s-apgw-fe-port-1"
      protocol                       = "Http"
      host_name                      = "sharmaji.club"
    }

    request_routing_rule = {
      name                       = "rg1k8s-apgw-req-route-rule-1"
      priority                   = 9
      rule_type                  = "Basic"
      http_listener_name         = "rg1k8s-apgw-http-listen-1"
      backend_address_pool_name  = "rg1k8s-apgw-be-pool-1"
      backend_http_settings_name = "rg1k8s-apgw-be-http-set-1"
    }
  }
}

var_root_acr = {
  acr1 = {
    acr_data = {
      acr_name            = "rg1k8sacr"
      resource_group_name = "rg1k8s"
      location            = "francecentral"
      sku                 = "Standard"
    }

    acr_role_assignment = {
      principal_id_k8s_name            = "rg1k8s-k8s"
      role_definition_name             = "AcrPull"
      scope                            = "rg1k8sacr"
      skip_service_principal_aad_check = true
    }
  }
}
