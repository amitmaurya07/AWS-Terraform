variable "name" {
  description = "Name of ECS Cluster(Elastic Container Service)"
  type = string
}

variable "ecs_cluster_id" {
  description = "Provide ECS Cluster ID"
  type = string
}

variable "port" {
  type = number
}

variable "vpc_id" {
  description = "Id of VPC"
  type = string
}

variable "subnet_id" {
  description = "ID of Public and Private Subnet"
  type = list(string)
}

variable "ecr_repo_url" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable"target_group_arn" {
    type = string
}