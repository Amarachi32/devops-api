module "acr_infra" {
  source              = "./modules/acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  acr_sku             = var.acr_sku
}

# 2. Call the AKS Cluster Module
module "aks" {
  source              = "./modules/aks"
  
  # Inputs from ACR module outputs
# resource_group_name = module.acr_infra.resource_group_name
  acr_id              = module.acr_infra.acr_id 
  
  # Inputs from root variables:
  resource_group_name = var.resource_group_name
  location            = var.location
  aks_name            = var.aks_name
  dns_prefix          = var.dns_prefix
  node_count          = var.node_count
  node_size           = var.node_size
}