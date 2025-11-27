output "resource_group_name" {
  description = "Name of the Resource Group used."
  value       = module.acr_infra.resource_group_name
}

output "acr_login_server" {
  description = "Login server URL of the ACR."
  value       = module.acr_infra.acr_login_server
}
