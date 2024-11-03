provider "aws" {
  region = var.region
}

module "terraform-s3" {
  source = "./modules/S3-Bucket-Website"
  name = var.s3_name
}