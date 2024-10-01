resource "aws_api_gateway_vpc_link" "periodic_table_vpc_link" {
  name        = "periodic-table-vpc-link-${var.env}"
  target_arns = [var.periodic_table_lb_arn]

  tags = {
    env = "${var.tag}"
  }
}