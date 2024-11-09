variable "region" {
  description = "Provide Region to deploy your AWS Reosurce"
  default = "ap-south-1"
  type = string
}

variable "aws_access_key_id" {
  description = "Access Key ID"
  type = string
}

variable "aws_secret_access_key" {
  description = "Secret Access Key ID"
  type = string
}

variable "name" {
  description = "Provide the name"
  type = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

# variable "vpc_id" {
#   description = "Id of VPC"
#   type = string
# }

# variable "subnet_id" {
#   description = "ID of Public and Private Subnet"
#   type = string
# }

# variable "sg_id" {
#   description = "Security Group ID"
#   type = string
# }