variable "region" {
  description = "AWS Region"
  type = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "aws_access_key_id" {
  description = "Access Key ID"
  type = string
}

variable "aws_secret_access_key" {
  description = "Secret Access Key ID"
  type = string
}
