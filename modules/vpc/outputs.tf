output "periodic_table_vpc_id" {
    description = "The id for the periodic table VPC"
    value       = aws_vpc.periodic_table_vpc.id
}

# output "periodic_table_subnet_one" {
#     description = "The first subnet for the periodic table VPC"
#     value       = aws_subnet.periodic_table_subnet_one.id
# }

output "periodic_table_subnet_two" {
    description = "The second subnet for the periodic table VPC"
    value       = aws_subnet.periodic_table_subnet_two.id
}

output "ecs_sg" {
    description = "The security group for the ecs on the periodic table VPC"
    value       = aws_security_group.ecs_sg.id
}