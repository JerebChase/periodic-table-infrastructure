resource "aws_apigatewayv2_vpc_link" "periodic_table_vpc_link" {
  name        = "periodic-table-vpc-link-${var.env}"
  security_group_ids = [var.periodic_table_sgs]
  subnet_ids         = [var.periodic_table_subnets]

  tags = {
    env = "${var.tag}"
  }
}