resource "aws_ecs_cluster" "periodic_table_cluster" {
  name = "periodic-table-cluster-${var.env}"
  tags = {
    env = "${var.tag}"
  }
}

resource "aws_ecs_task_definition" "periodic_table_task" {
  family                   = "periodic-table-container-${var.env}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = var.ecs_role_arn
  cpu                      = "256"     # 0.25 vCPU
  memory                   = "512"     # 0.5 GB memory

  container_definitions = jsonencode([{
    name  = "periodic-table-container-${var.env}"
    image = "${var.ecr_repository_url}:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
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
    subnets          = [var.periodic_table_subnet]
    security_groups  = [var.periodic_table_sg]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.periodic_table_lb_arn
    container_name   = "periodic-table-container-${var.env}"
    container_port   = 80
  }

  tags = {
    env = "${var.tag}"
  }
}