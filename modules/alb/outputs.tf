output "periodic_table_lb_arn" {
    description = "The arn for the application lb"
    value       = aws_lb.periodic_table_alb.arn
}

output "periodic_table_lb_dns_name" {
    description = "The dns name for the application lb"
    value       = aws_lb.periodic_table_alb.dns_name
}

# output "periodic_table_tg_arn" {
#     description = "The arn for the target group"
#     value       = aws_lb_target_group.periodic_table_tg.arn
# }