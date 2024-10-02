output "periodic_table_lb_arn" {
    description = "The arn for the network lb"
    value       = aws_lb.periodic_table_nlb.arn
}

output "periodic_table_lb_dns_name" {
    description = "The dns name for the network lb"
    value       = aws_lb.periodic_table_nlb.dns_name
}