output "vpc_id" {
  value = aws_vpc.three-tier.id
}

output "subnet_id" {
  value = aws_subnet.public[*].id
}