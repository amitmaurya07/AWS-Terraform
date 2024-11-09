output "dns_name" {
  value       = aws_lb.three-tier.dns_name
}

output "arn" {
  value = aws_lb.three-tier.arn
}

output "tg-arn" {
  value = aws_lb_target_group.ip-frontend.arn
}

output "tg-arn-backend" {
  value = aws_lb_target_group.ip-backend.arn
}