provider "aws" {
  region = var.region
}

module "ec2_db" {
  source = "./modules/aws_ec2_module"
  security_group_ids = [module.aws_security_group.security_group_id]
  name = "${var.name}-mogodb"
  ami = "ami-09b0a86a2c84101e1"
  instance_type = "t2.micro"
  subnet_id = module.vpc.public_subnet_id[0]
}

module "vpc" {
  source = "./modules/vpc-module"
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "aws_security_group" {
  source = "./modules/security-group"
  sg_name = "${var.name}-sg"
  vpc_id = module.vpc.vpc_id
}

module "aws_lb" {
  source = "./modules/aws_alb_module"
  name = "${var.name}-alb"
  security_group_id = module.aws_security_group.security_group_id
  subnet_id = module.vpc.public_subnet_id
  vpc_id = module.vpc.vpc_id
}

module "frontend-aws_ecr" {
  source = "./modules/aws_ecr_module"
  name = "${var.name}-frontend"
}

module "backend-aws_ecr" {
  source = "./modules/aws_ecr_module"
  name = "${var.name}-backend"
}

module "aws_ecs_cluster" {
  source = "./modules/aws_ecs_cluster_module"
  name = var.name
}

module "frontend-ecs" {
  source = "./modules/aws_ecs_module"
  name = "${var.name}-frontend-ecs"
  ecr_repo_url = module.frontend-aws_ecr.frontend-repository_url
  image_tag = "3"
  ecs_cluster_id = module.aws_ecs_cluster.ecs_cluster_id
  port = 5173
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
  security_group_id = module.aws_security_group.security_group_id
  target_group_arn = module.aws_lb.tg-arn
}

module "backend-ecs" {
  source = "./modules/aws_ecs_module"
  name = "${var.name}-backend-ecs"
  ecr_repo_url = module.backend-aws_ecr.frontend-repository_url
  port = 5000
  ecs_cluster_id = module.aws_ecs_cluster.ecs_cluster_id
  image_tag = "2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnet_id
  security_group_id = module.aws_security_group.security_group_id
  target_group_arn = module.aws_lb.tg-arn-backend
}