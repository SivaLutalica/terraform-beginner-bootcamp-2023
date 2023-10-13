terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_krupa_hosting" {
	source = "./modules/terrahome_aws"
	user_uuid = var.teacherseat_user_uuid
	public_path = var.krupa.public_path
  content_version = var.krupa.content_version
}

resource "terratowns_home" "home_krupa" {
  name = "Krupa na vrbasu"
  description = <<DESCRIPTION
Small town in Bosnia and Herzegovina that is worth a stop
DESCRIPTION
  domain_name = module.home_krupa_hosting.domain_name
  town = "the-nomad-pad"
  content_version = var.krupa.content_version
}

module "home_blood_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.blood.public_path
  content_version = var.blood.content_version
}

resource "terratowns_home" "home_blood" {
  name = "Blood"
  description = <<DESCRIPTION
An old game we used to play with great passion
DESCRIPTION
  domain_name = module.home_blood_hosting.domain_name
  town = "gamers-grotto"
  content_version = var.blood.content_version
}