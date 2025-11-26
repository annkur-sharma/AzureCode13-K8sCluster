variable "var_child_kubernetes_cluster" {
  description = "The details of the K8s Cluster"
  type = map(object(
    {
      resource_group_name  = string
      resource_location    = string
      k8s_cluster_name     = string
      k8s_cluster_dns_name = string

      kubernetes_version = string

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
