provider "aws" {
  region = "ap-south-1"
}

# Security group allowing SSH + HTTP (port 3000)
resource "aws_security_group" "web_sg" {
  name        = "cloudscale-web-sg"
  description = "Allow SSH and HTTP"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Single EC2 instance
resource "aws_instance" "web" {
  ami                    = "ami-0c42696027a8ede58"   # Amazon Linux 2 Free Tier
  instance_type          = "t2.micro"               # Free Tier eligible
  key_name               = "cloudscale-key"         # Use your existing key pair
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "CloudScale-SingleEC2"
  }
}
