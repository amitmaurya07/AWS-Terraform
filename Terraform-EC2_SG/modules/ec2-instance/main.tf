resource "aws_instance" "ec2_instance" {
  ami = var.ami 
  instance_type = var.instance_type
  vpc_security_group_ids = var.security_group_ids

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt install nginx -y
              systemctl start nginx
              systemctl enable nginx
              EOF
  tags = {
    Name = "Terraform Instance"
  }
}
