resource "aws_lb" "periodic_table_alb" {
  name               = "periodic-table-alb-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg] 
  subnets            = var.periodic_table_subnets

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_lb_target_group" "periodic_table_tg" {
  name        = "periodic-table-tg-${var.env}"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.periodic_table_vcp_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_lb_listener" "periodic_table_listener" {
  load_balancer_arn = aws_lb.periodic_table_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.periodic_table_tg.id
    type             = "forward"
  }
}