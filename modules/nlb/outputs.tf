output "periodic_table_lb_arn" {
    description = "The arn for the network lb"
    value       = aws_lb.periodic_table_nlb.arn
}