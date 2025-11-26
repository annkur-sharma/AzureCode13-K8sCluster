variable "var_child_resource_group" {
  description = "The details of the resource group"
  type = map(object(
    {
      resource_group_name = string
      resource_location = string
    }
  ))
}

