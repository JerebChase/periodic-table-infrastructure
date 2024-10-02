resource "aws_lb" "periodic_table_nlb" {
  name               = "periodic-table-nlb-${var.env}"
  internal           = true
  load_balancer_type = "network"
  subnets            = ["${var.periodic_table_subnet}"]

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_lb_target_group" "periodic_table_tg" {
  name        = "periodic-table-tg-${var.env}"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.periodic_table_vcp_id
  target_type = "ip"

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_lb_listener" "periodic_table_listener" {
  load_balancer_arn = aws_lb.periodic_table_nlb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.periodic_table_tg.id
    type             = "forward"
  }
}