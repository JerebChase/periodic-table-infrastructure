resource "aws_ecs_cluster" "periodic_table_cluster" {
  name = "periodic-table-cluster"
}

resource "aws_ecs_task_definition" "periodic_table_task" {
  family                   = "periodic-table-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.ecs_role_arn
  cpu                      = "256"     # 0.25 vCPU
  memory                   = "512"     # 0.5 GB memory

  container_definitions = jsonencode([{
    name  = "periodic-table-container"
    image = "${var.ecr_repository_url}:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
}

resource "aws_ecs_service" "periodic_table_service" {
  name            = "periodic-table-service"
  cluster         = aws_ecs_cluster.periodic_table_cluster.id
  task_definition = aws_ecs_task_definition.periodic_table_task.arn
  desired_count   = 1

  network_configuration {
    subnets          = [var.periodic_table_subnet]
    security_groups  = [var.periodic_table_sg]
    assign_public_ip = true
  }
}