variable "terratowns_endpoint" {
 type = string
}

variable "terratowns_access_token" {
 type = string
}

variable "teacherseat_user_uuid" {
  type = string
}

variable "index_html_filepah" {
	description = "The file path for index.html"
	type = string
}

variable "error_html_filepah" {
	description = "The file path for error.html"
	type = string
}

variable "content_version" {
	description = "Set the content version"
	type = number
}

variable "assets_path" {
  description = "Path to assets folder"
  type = string
}