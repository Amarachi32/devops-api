output "resource_group_name" {
  description = "Name of the Resource Group used."
  value       = module.acr_infra.resource_group_name
}

output "acr_login_server" {
  description = "Login server URL of the ACR."
  value       = module.acr_infra.acr_login_server
}

output "aks_cluster_name" {
  description = "The name of the created AKS cluster."
  value       = module.aks.aks_cluster_name
}

output "kube_config" {
  description = "Raw Kubernetes configuration for connecting to AKS."
  sensitive   = true
  value       = module.aks.aks_kube_config_raw
}