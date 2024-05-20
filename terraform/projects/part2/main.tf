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
  default     = 8080
  type        = number
}


resource "aws_security_group" "instance" {
  name = "terraform-lb-instance"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_launch_configuration" "example" {
  instance_type   = "t2.micro"
  image_id        = "ami-04b70fa74e45c3917"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
        #!/bin/bash
          apt-get update
          apt-get install -y apache2
          sed -i -e 's/80/${var.server_port}/' /etc/apache2/ports.conf
          echo "Hello World" > /var/www/html/index.html
          systemctl restart apache2
          EOF

  lifecycle {
    create_before_destroy = true
  }
}

# get the details of the default vpc
data "aws_vpc" "default" {
  default = true
}

# use the default vpc and get the subnet ids
data "aws_subnet" "default_subnet_ids" {
  vpc_id = data.aws_vpc.default.id


  #   # Add a filter based on availability zone to narrow down the matches
  filter {
    name   = "availabilityZone"
    values = ["us-east-1a"] # Replace with the desired availability zone
  }
}

data "aws_subnet" "default_subnet_ids2" {
  vpc_id = data.aws_vpc.default.id


  #   # Add a filter based on availability zone to narrow down the matches
  filter {
    name   = "availabilityZone"
    values = ["us-east-1b"] # Replace with the desired availability zone
  }
}


resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  # use the default subnet ids
  vpc_zone_identifier = [data.aws_subnet.default_subnet_ids.id]
  target_group_arns   = [aws_lb_target_group.asg.arn]
  health_check_type   = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "alb" {
  name = "terraform-example-alp"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_lb" "example" {
  name               = "terraform-asg-alb-example"
  load_balancer_type = "application"
  subnets            = [data.aws_subnet.default_subnet_ids.id, data.aws_subnet.default_subnet_ids2.id]
  security_groups    = [aws_security_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: Page not Found"
      status_code  = 404
    }
  }
}

resource "aws_lb_target_group" "asg" {
  name     = "terraform-example-targets"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = 200
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 1
  condition {
    path_pattern {
      values = ["*"]
    }
  }
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

output "alb_dns_name" {
  value       = aws_lb.example.dns_name
  description = "Domain name of the loadbalancer"
}
