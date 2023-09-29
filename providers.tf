terraform {
  cloud {
    organization = "grgicv-terraform-bootcamp-2023"

    workspaces {
      name = "terra-house-1"
    }
  }
}