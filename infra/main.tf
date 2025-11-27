module "module_resource_group" {
  source                   = "../modules/01-azurerm_resource_group"
  var_child_resource_group = var.var_root_resource_group
}

module "module_vnet" {
  depends_on     = [module.module_resource_group]
  source         = "../modules/02-azurerm_vnet"
  var_child_vnet = var.var_root_vnet
}

module "module_subnet" {
  depends_on       = [module.module_resource_group, module.module_vnet]
  source           = "../modules/03-azurerm_subnet"
  var_child_subnet = var.var_root_subnet
}

module "module_public_ip_app_gateway" {
  depends_on          = [module.module_resource_group, module.module_vnet, module.module_subnet]
  source              = "../modules/04-azurerm_public_ip"
  var_child_public_ip = var.var_root_public_ip
}

module "module_application_gateway" {
  depends_on                    = [module.module_resource_group, module.module_vnet, module.module_subnet, module.module_public_ip_app_gateway]
  source                        = "../modules/05-azurerm_application_gateway"
  var_child_application_gateway = var.var_root_application_gateway
}

module "module_kubernetes_cluster" {
  depends_on                   = [module.module_resource_group, module.module_vnet, module.module_subnet, module.module_application_gateway]
  source                       = "../modules/06-azurerm_kubernetes_cluster"
  var_child_kubernetes_cluster = var.var_root_kubernetes_cluster
}

module "module_acr" {
  depends_on    = [module.module_resource_group, module.module_vnet, module.module_subnet, module.module_application_gateway, module.module_kubernetes_cluster]
  source        = "../modules/07-azurerm_container_registry"
  var_child_acr = var.var_root_acr
}

module "module_sql_server" {
  depends_on    = [module.module_resource_group]
  source        = "../modules/08-azurerm_mssql_server"
  var_child_sqlserver = var.var_root_sqlserver
}

module "module_sql_database" {
  depends_on    = [module.module_resource_group, module.module_sql_server]
  source        = "../modules/09-azurerm_mssql_database"
  var_child_sql_database = var.var_root_sql_database
}