provider "aws" {
  region = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

module "ec2_instance" {
  source = "./modules/ec2-instance"
  ami = "ami-09b0a86a2c84101e1"
  instance_type = var.instance_type
  security_group_ids = [module.ec2_sg.security_group_id]
}

module "ec2_sg" {
  source = "./modules/security-group"
  sg_name = "EC2-securitygroup"
}

output "instance_id" {
  value = module.ec2_instance.instance_id
}

output "public_ip" {
  value = module.ec2_instance.public_ip
}

output "security_group_id" {
  value = module.ec2_sg.security_group_id
}