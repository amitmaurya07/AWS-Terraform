output "vpc_id" {
  value = aws_vpc.three-tier.id
}

output "public_subnet_id" {
  value = aws_subnet.public[*].id
}

output "subnet_id" {
  value = aws_subnet.private[*].id
}