module "acr_infra" {
  source              = "./modules/acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  acr_sku             = var.acr_sku
}
