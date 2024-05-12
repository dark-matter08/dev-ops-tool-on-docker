terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }

    required_version = "1.8.3"
}

provider "aws" {
  region = "us-east-1"
}

variable "server_port" {
    description = "The server's port"
    default = 8080
    type = number
}

resource "aws_instance" "terra_server" {
    ami = "ami-04b70fa74e45c3917" # - old ami per the tutorial "ami-0c55b159cbfafe10"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
        #!/bin/bash
        echo "Hello, World" > index.html
        nohup busybox httpd -f -p ${var.server_port} &
        EOF

    tags = {
      Name = "terra-server"
    }
}

resource "aws_security_group" "instance" {
  name = "terraform-instance"
  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.terra_server.public_ip
  description = "The public IP address of the webserver"
}
