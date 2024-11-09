resource "aws_instance" "ec2_instance" {
  ami = var.ami 
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo docker run -d --name mongodb -p 27017:27017 mongo:4.4
  EOF
  tags = {
    Name = var.name
  }
}
