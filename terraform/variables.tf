# Define input variables for the Terraform module
variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to create the ACR and Kubernetes Service in"
}

variable "location" {
  type        = string
  description = "Azure region to deploy resources in"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry to create"
}

variable "k8s_name" {
  type        = string
  description = "Name of the Azure Kubernetes Service to create"
}
variable "kubernetes_version" {
  type = string
  description = "kube version"
}

variable "node_count" {
  type        = number
  description = "Number of nodes to create in the Kubernetes cluster"
}

variable "node_vm_size" {
  type        = string
  description = "Size of the virtual machines to use for the Kubernetes nodes"
}

# variable "sp_client_id" {
#   type        = string
#   description = "Client ID of the Service Principal to use for authentication"
# }

# variable "sp_client_secret" {
#   type        = string
#   description = "Client Secret of the Service Principal to use for authentication"
# }


