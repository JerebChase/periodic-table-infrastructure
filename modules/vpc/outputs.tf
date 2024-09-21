output "periodic_table_subnet" {
    description = "The subnet for the periodic table VPC"
    value       = aws_subnet.periodic_table_subnet.id
}

output "periodic_table_sg" {
    description = "The security group for the periodic table VPC"
    value       = aws_security_group.periodic_table_sg.id
}