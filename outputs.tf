output "krupa_bucket_name" {
	description = "Bucket Name for our static website hosting for Krupa"
	value = module.home_krupa_hosting.bucket_name
}

output "krupa_s3_website_endpoint" {
	description = "S3 static website hosting endpoint for Krupa"
	value = module.home_krupa_hosting.website_endpoint
}

output "krupa_cloudfront_url" {
  description = "The CloudFront Distribution Domain Name for Krupa"
  value = module.home_krupa_hosting.domain_name
}

output "blood_bucket_name" {
	description = "Bucket Name for our static website hosting for Blood"
	value = module.home_blood_hosting.bucket_name
}

output "blood_s3_website_endpoint" {
	description = "S3 static website hosting endpoint for Blood"
	value = module.home_blood_hosting.website_endpoint
}

output "blood_cloudfront_url" {
  description = "The CloudFront Distribution Domain Name for Blood"
  value = module.home_blood_hosting.domain_name
}