output "resource_group_name" {
  description = "Name of the Resource Group used."
  value       = var.resource_group_name
}

output "acr_login_server" {
  description = "Login server URL of the ACR."
  value       = azurerm_container_registry.acr.login_server
}

output "acr_id" {
  description = "Resource ID of the ACR."
  value       = azurerm_container_registry.acr.id
}
