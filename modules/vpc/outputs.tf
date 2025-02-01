output "periodic_table_vpc_id" {
    description = "The id for the periodic table VPC"
    value       = aws_vpc.periodic_table_vpc.id
}

output "periodic_table_public_subnets" {
    description = "The public subnets for the periodic table VPC"
    value       = [aws_subnet.periodic_table_subnet1.id, aws_subnet.periodic_table_subnet2.id]
}

output "periodic_table_private_subnets" {
  description = "The private subnets for the periodic table VPC"
  value       = [aws_subnet.periodic_table_private_subnet1.id, aws_subnet.periodic_table_private_subnet2.id]
}

output "ecs_sg" {
    description = "The security group for the ecs on the periodic table VPC"
    value       = aws_security_group.ecs_sg.id
}

output "alb_sg" {
    description = "The security group for the alb on the periodic table VPC"
    value       = aws_security_group.alb_sg.id
}