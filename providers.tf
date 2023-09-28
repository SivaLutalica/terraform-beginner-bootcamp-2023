terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
  cloud {
    organization = "grgicv-terraform-bootcamp-2023"

    workspaces {
      name = "terra-house-1"
    }
  }
}
provider "aws" {
  # Configuration options
}