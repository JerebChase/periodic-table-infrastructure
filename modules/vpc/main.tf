resource "aws_vpc" "periodic_table_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "periodic_table_subnet" {
  vpc_id            = aws_vpc.periodic_table_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
}

resource "aws_security_group" "periodic_table_sg" {
  vpc_id = aws_vpc.periodic_table_vpc.id

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