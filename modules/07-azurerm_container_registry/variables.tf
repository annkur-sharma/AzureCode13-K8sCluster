variable "var_child_acr" {
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
          principal_id_k8s_name                     = string
          role_definition_name             = string
          scope                            = string
          skip_service_principal_aad_check = bool
        }
      )
    }
  ))
}
