output "instance_id_main" {
  description = "The ID of the EC2 instance"
  value       = module.ec2_instance.instance_id
}

output "public_ip_main" {
  description = "The public IP of the EC2 instance"
  value       = module.ec2_instance.public_ip
}