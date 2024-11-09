variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "name" {
  description = "Provide the name of Frontend ECR Repository"
  type = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the instance"
  type        = list(string)
}

variable "subnet_id" {
  description = "Subnet ID to attach to the instance"
  type        = string
}
