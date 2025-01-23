resource "aws_ecs_cluster" "periodic_table_cluster" {
  name = "periodic-table-cluster-${var.env}"
  tags = {
    env = "${var.tag}"
  }
}

resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/spring-boot"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "periodic_table_task" {
  family                   = "periodic-table-task-${var.env}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.ecs_task_role_arn
  task_role_arn            = var.ecs_task_role_arn 
  cpu                      = "256"     # 0.25 vCPU
  memory                   = "512"     # 0.5 GB memory

  container_definitions = jsonencode([{
    name  = "periodic-table-container-${var.env}"
    image = "${var.ecr_repository_url}:latest"
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group  = "/ecs/spring-boot"
        awslogs-region = "us-east-1"
        awslogs-stream-prefix = "ecs"
      }
    }
    runtime_platform = {
      operating_system_family = "LINUX"
      cpu_architecture        = "ARM64"
    }
    tags = {
      env = "${var.tag}"
    }
  }])

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_ecs_service" "periodic_table_service" {
  name            = "periodic-table-service-${var.env}"
  cluster         = aws_ecs_cluster.periodic_table_cluster.id
  task_definition = aws_ecs_task_definition.periodic_table_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.periodic_table_subnets
    security_groups  = [var.ecs_sg]
    assign_public_ip = true
  }

  # load_balancer {
  #   target_group_arn = var.periodic_table_tg_arn
  #   container_name   = "periodic-table-container-${var.env}"
  #   container_port   = 8080
  # }

  tags = {
    env = "${var.tag}"
  }
}