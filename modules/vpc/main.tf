resource "aws_vpc" "periodic_table_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    env = "${var.tag}"
  }
}

resource "aws_subnet" "periodic_table_subnet_one" {
  vpc_id            = aws_vpc.periodic_table_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_subnet" "periodic_table_subnet_two" {
  vpc_id            = aws_vpc.periodic_table_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.periodic_table_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    env = "${var.tag}"
  }
}