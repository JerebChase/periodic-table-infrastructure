output "periodic_table_vpc_link" {
    description = "VPC link for periodic table"
    value       = aws_api_gateway_vpc_link.periodic_table_vpc_link.id
}