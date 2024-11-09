output "frontend-repository_url" {
  value = module.frontend-aws_ecr.frontend-repository_url
}

output "frontend-repositoy_name" {
  value = module.frontend-aws_ecr.frontend-repositoy_name
}

output "backend-repository_url" {
  value = module.backend-aws_ecr.frontend-repository_url
}

output "backend-repositoy_name" {
  value = module.backend-aws_ecr.frontend-repositoy_name
}

output "dns_name" {
  description = "The DNS name of the load balancer"
  value       = module.aws_lb.dns_name
}

output "tg-arn" {
  value = module.aws_lb.tg-arn
}

output "tg-arn-backend" {
  value = module.aws_lb.tg-arn-backend
}

output "ecs_cluster_id" {
  value = module.aws_ecs_cluster.ecs_cluster_id
}