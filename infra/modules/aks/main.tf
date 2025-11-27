
# 1. Create the Azure Kubernetes Service (AKS) Cluster
resource "azurerm_kubernetes_cluster" "main" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  sku_tier            = "Free" 
  
  # Use System-assigned identity (Required for role assignment)
  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                 = "default"
    vm_size              = var.node_size
    node_count           = var.node_count
    os_disk_size_gb      = 30 
  }

  kubernetes_version = "1.28" # Use a stable, recent version
  role_based_access_control_enabled = true
}

# 2. Grant AKS Identity permissions to pull images from ACR (Security Bonus)
# This grants the least privilege needed (AcrPull) using the ACR ID passed in.
resource "azurerm_role_assignment" "acr_pull_permission" {
  scope                = var.acr_id 
  role_definition_name = "AcrPull" 
  principal_id         = azurerm_kubernetes_cluster.main.identity[0].principal_id
}