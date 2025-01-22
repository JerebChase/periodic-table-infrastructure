output "periodic_table_vpc_id" {
    description = "The id for the periodic table VPC"
    value       = aws_vpc.periodic_table_vpc.id
}

output "periodic_table_subnet" {
    description = "The subnet for the periodic table VPC"
    value       = aws_subnet.periodic_table_subnet.id
}

output "ecs_sg" {
    description = "The security group for the ecs on the periodic table VPC"
    value       = aws_security_group.ecs_sg.id
}

output "alb_sg" {
    description = "The security group for the alb on the periodic table VPC"
    value       = aws_security_group.alb_sg.id
}