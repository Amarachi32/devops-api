# modules/aks/outputs.tf

output "aks_cluster_name" {
  description = "The name of the created AKS cluster."
  value       = azurerm_kubernetes_cluster.main.name
}

output "aks_kube_config_raw" {
  description = "The raw kubeconfig required to connect to the AKS cluster."
  sensitive   = true
  value       = azurerm_kubernetes_cluster.main.kube_config_raw
}