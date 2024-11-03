variable "region" {
  description = "AWS Region to deploy bucket"
}

variable "aws_access_key_id" {
  description = "Access Key ID"
  type = string
}

variable "aws_secret_access_key" {
  description = "Secret Access Key ID"
  type = string
}

variable "s3_name" {
  description = "Provide the name of bucket"
  type = string
}