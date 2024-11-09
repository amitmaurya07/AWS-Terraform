variable "name" {
  type = string
}

variable "security_group_id" {
    type = string
}

variable "subnet_id" {
  description = "ID of Public and Private Subnet"
  type = list(string)
}

variable "vpc_id" {
  description = "Id of VPC"
  type = string
}

