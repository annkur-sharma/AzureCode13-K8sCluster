resource "azurerm_kubernetes_cluster" "child_kubernetes_cluster" {
  for_each = var.var_child_kubernetes_cluster

  name                = each.value.k8s_cluster_name
  location            = each.value.resource_location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.k8s_cluster_dns_name

  default_node_pool {
    name           = each.value.default_node_pool.name       # "system"
    node_count     = each.value.default_node_pool.node_count # 2
    vm_size        = each.value.default_node_pool.vm_size    # "Standard_D2ds_v4"
    vnet_subnet_id = data.azurerm_subnet.get_child_subnet_k8s[each.key].id
    max_pods       = each.value.default_node_pool.max_pods
    type           = each.value.default_node_pool.type
  }

  identity {
    type = each.value.identity.type
  }

  network_profile {
    network_plugin      = each.value.network_profile.network_plugin      #"azure"   # ✅ Enables Azure CNI networking
    network_plugin_mode = each.value.network_profile.network_plugin_mode # "overlay" # ✅ Enables Azure CNI with overlay mode
    network_policy      = each.value.network_profile.network_policy      #"calico"  # ✅ Allows use of Calico for network policy enforcement
    load_balancer_sku   = each.value.network_profile.load_balancer_sku   #"standard"
    service_cidr        = "10.200.0.0/16"
    dns_service_ip      = "10.200.0.10"
  }

  ingress_application_gateway {
    gateway_id = data.azurerm_application_gateway.get_child_application_gateway[each.key].id
    # gateway_name = each.value.ingress_application_gateway.gateway_name
    # subnet_id = lookup(each.value.ingress_application_gateway, "subnet_id", null)
    # subnet_cidr = lookup(each.value.ingress_application_gateway, "subnet_cidr", null)
  }

}
