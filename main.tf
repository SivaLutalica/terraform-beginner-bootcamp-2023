terraform {

}
module "terrahouse_aws" {
	source = "./modules/terrahouse_aws"
	user_uuid = var.user_uuid
	bucket_name = var.bucket_name
	index_html_filepah = var.index_html_filepah
	error_html_filepah = var.error_html_filepah
	content_version = var.content_version
}