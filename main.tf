resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_instance" "terraform_ec2" {
  ami                    = "ami-0dba2cb6798deb6d8"  # Replace with your Ubuntu 22.04 AMI
  instance_type          = "t3.micro"
  key_name               = "my-key"                 # Replace with your key pair
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "terraform-ec2-instance"
  }
}
