variable "resource_group_name" {}
variable "location" {}
variable "acr_sku" {}

variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

variable "aks_name" {
  description = "Name for the AKS cluster."
  type        = string
  default     = "aks-test-01"
}

variable "dns_prefix" {
  description = "DNS prefix for the AKS Load Balancer/Public IP."
  type        = string
  default     = "aks-dns-test"
}

variable "node_count" {
  description = "Number of worker nodes (1 or 2 for cost-effectiveness)."
  type        = number
  default     = 1
}

variable "node_size" {
  description = "VM size for AKS nodes (Standard_B2s for cost-effectiveness)."
  type        = string
  default     = "Standard_B2s"
}