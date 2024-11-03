resource "aws_s3_bucket" "terraform-s3" {
  bucket = "${var.name}-${random_id.suffix.hex}"

  tags = {
    Name = var.name
  }
}

resource "random_id" "suffix" {
  byte_length = 3
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.terraform-s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.terraform-s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.terraform-s3.arn}/*"
      }
    ]
  })
}

resource "aws_s3_object" "upload" {
  bucket = aws_s3_bucket.terraform-s3.id
  source = "./modules/S3-Bucket-Website/assets/index.html"
  key = "index.html" 
  content_type = "text/html"
  etag = filemd5("./modules/S3-Bucket-Website/assets/index.html")
}

resource "aws_s3_object" "upload_error" {
  bucket = aws_s3_bucket.terraform-s3.id
  source = "./modules/S3-Bucket-Website/assets/error.html"
  key = "error.html" 
  content_type = "text/html"
  etag = filemd5("./modules/S3-Bucket-Website/assets/error.html")
}

resource "aws_s3_bucket_website_configuration" "static-website" {
  bucket = aws_s3_bucket.terraform-s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}


