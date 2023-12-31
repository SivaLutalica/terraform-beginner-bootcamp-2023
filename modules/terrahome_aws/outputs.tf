output "bucket_name" {
  description = "Bucket Name for our static website hosting"
  value = aws_s3_bucket.website_bucket.bucket
}

output "website_endpoint" {
	description = "S3 static website hosting endpoint"
	value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}

output "domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}