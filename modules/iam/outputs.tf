output "ecs_task_role_arn" {
    description = "The arn of the ecs task execution role"
    value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_service_role_arn" {
    description = "The arn of the ecs service role"
    value       = aws_iam_role.ecs_service_role.arn
}