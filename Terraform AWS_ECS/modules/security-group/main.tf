data "aws_vpc" "vpc" {
  id = var.vpc_id
}
resource "aws_security_group" "ec2_sg" {
  name        = var.sg_name
  description = "Security group for EC2 instance"
  vpc_id = data.aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr] 
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

    ingress {
    from_port   = 5173
    to_port     = 5173
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  tags = {
    Name = var.sg_name
  }
}
