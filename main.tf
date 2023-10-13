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

module "terrahouse_aws" {
	source = "./modules/terrahouse_aws"
	user_uuid = var.teacherseat_user_uuid
	index_html_filepah = var.index_html_filepah
	error_html_filepah = var.error_html_filepah
	content_version = var.content_version
	assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "Krupa na vrbasu"
  description = <<DESCRIPTION
Small town in Bosnia and Herzegovina that is worth a stop
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "the-nomad-pad"
  content_version = 1
}