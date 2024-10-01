resource "aws_lb" "periodic_table_nlb" {
  name               = "periodic-table-nlb-${var.env}"
  internal           = false
  load_balancer_type = "network"
  subnets            = "${var.periodic_table_subnet}"

  tags = {
    env  = "${var.tag}"
  }
}

resource "aws_lb_target_group" "periodic_table_tg" {
  name        = "periodic-table-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.periodic_table_vcp_id
  target_type = "ip"

  health_check {
    path = "/"
    protocol = "HTTP"
  }

  tags = {
    env  = "${var.tag}"
  }
}