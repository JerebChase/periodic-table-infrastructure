output "periodic_table_rg" {
    description = "Resource group name for the periodic table"
    value       = aws_api_gateway_vpc_link.periodic_table_vpc_link.id
}