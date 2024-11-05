variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "ec2_security_group"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH"
  type        = string
  default     = "0.0.0.0/0" 
}

variable "vpc_id" {
  description = "Id of VPC"
  type = string
}
