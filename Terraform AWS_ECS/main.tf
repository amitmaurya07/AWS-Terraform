provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc-module"
}

module "aws_security_group" {
  source = "./modules/security-group"
  sg_name = "${var.name}-sg"
  vpc_id = module.vpc.vpc_id
}

module "aws_ecr" {
  source = "./modules/aws_ecr_module"
  name = var.name
}

module "aws_ecs" {
  source = "./modules/aws_ecs_module"
  name = "${var.name}-ecs"
  ecr_repo_url = module.aws_ecr.repository_url
  image_tag = "latest"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
  security_group_id = module.aws_security_group.security_group_id
  sg_id = module.aws_security_group.security_group_id
}