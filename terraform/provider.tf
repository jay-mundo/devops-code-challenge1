# provider.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.19.0"   # Use latest stable version
    }
  }

  required_version = ">= 1.6.0"
}

provider "aws" {
  region = var.aws_region
}
