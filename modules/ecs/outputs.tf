output "periodic_table_cluster"{
    description = "The cluster name for ecs"
    value       = aws_ecs_cluster.periodic_table_cluster.name
}

output "periodic_table_service" {
    description = "The service name for ecs"
    value       = aws_ecs_service.periodic_table_service.name
}