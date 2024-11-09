output "frontend-repository_url" {
  value = aws_ecr_repository.three-tier-frontend.repository_url
}

output "frontend-repositoy_name" {
  value = aws_ecr_repository.three-tier-frontend.name
}