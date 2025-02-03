resource "aws_vpc" "periodic_table_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    env = "${var.tag}"
  }
}

resource "aws_subnet" "periodic_table_subnet1" {
  vpc_id            = aws_vpc.periodic_table_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_subnet" "periodic_table_subnet2" {
  vpc_id            = aws_vpc.periodic_table_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.periodic_table_vpc.id

  # Allow HTTP traffic
  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic
  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ecs_sg" {
  vpc_id = aws_vpc.periodic_table_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_internet_gateway" "periodic_table_gw" {
  vpc_id = aws_vpc.periodic_table_vpc.id

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_route_table" "periodic_table_rt" {
  vpc_id = aws_vpc.periodic_table_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.periodic_table_gw.id
  }

  tags = {
    env  = "${var.tag}"
  }
}

resource "aws_route_table_association" "periodic_table_rta1" {
  subnet_id      = aws_subnet.periodic_table_subnet1.id
  route_table_id = aws_route_table.periodic_table_rt.id
}

resource "aws_route_table_association" "periodic_table_rta2" {
  subnet_id      = aws_subnet.periodic_table_subnet2.id
  route_table_id = aws_route_table.periodic_table_rt.id
}