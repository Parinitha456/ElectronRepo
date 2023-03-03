# Create an Azure resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create an Azure Container Registry
resource "azurerm_container_registry" "my_acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.k8s_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.k8s_name
  
  default_node_pool {
    name                = "system"
    node_count          = var.node_count
    vm_size             = var.node_vm_size
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false

  }

  identity {
    type = "SystemAssigned"
  }
  
  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet" 
    network_policy = "calico"
  }

  role_based_access_control {    
    enabled = true
  }
}


provider "kubernetes" {
  host                   = "${resource.azurerm_kubernetes_cluster.aks.kube_config.0.host}"
  client_certificate     = "${base64decode(resource.azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate)}"
  client_key             = "${base64decode(resource.azurerm_kubernetes_cluster.aks.kube_config.0.client_key)}"
  cluster_ca_certificate = "${base64decode(resource.azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)}"
}

