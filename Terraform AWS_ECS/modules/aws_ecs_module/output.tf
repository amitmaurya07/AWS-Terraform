output "ecs_cluster" {
  value = aws_ecs_cluster.three-tier.id
}

output "task_role_arn" {
  value = aws_iam_role.three-tier-role.arn
}
