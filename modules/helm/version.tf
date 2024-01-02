terraform {
  required_version = "> 0.13.0"
  required_providers {

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = var.config_path
  }
}