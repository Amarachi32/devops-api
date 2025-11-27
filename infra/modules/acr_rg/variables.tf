variable "resource_group_name" {
  description = "Existing Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "acr_sku" {
  description = "SKU for ACR."
  type        = string
  default     = "Basic"
}
