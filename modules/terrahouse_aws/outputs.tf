output "bucket_name" {
  description = "Bucket Name for our static website hosting"
  value = aws_s3_bucket.website_bucket.bucket
}