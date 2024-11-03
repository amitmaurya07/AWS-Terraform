output "bucket_domain" {
  value = aws_s3_bucket.terraform-s3.bucket_domain_name
}

output "website" {
  value = "http://${aws_s3_bucket.terraform-s3.website_endpoint}"
}