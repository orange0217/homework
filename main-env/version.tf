terraform {
  required_version = "> 0.13.0"
  required_providers {

    tencentcloud = {
      source  = "tencentcloudstack/tencentcloud"
      version = "1.81.5"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }
}

provider "tencentcloud" {
  secret_id  = var.secret_id
  secret_key = var.secret_key
  region     = var.region
}
provider "helm" {
  kubernetes {
    config_path = local_sensitive_file.kubeconfig.filename
  }
}