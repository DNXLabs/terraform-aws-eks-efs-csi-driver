terraform {
  required_version = ">= 0.13"

  required_providers {
    aws        = ">= 3.13, < 4.0"
    helm       = ">= 1.0, < 1.4.0"
    kubernetes = ">= 1.10.0"
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.9.4"
    }
  }
}