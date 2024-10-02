resource "aws_api_gateway_rest_api" "periodic_table_api" {
  name = "periodic-table-api-${var.env}"
  tags = {
    env = "${var.tag}"
  }
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.periodic_table_api.id
  parent_id   = aws_api_gateway_rest_api.periodic_table_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.periodic_table_api.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ecs_integration" {
  rest_api_id     = aws_api_gateway_rest_api.periodic_table_api.id
  resource_id     = aws_api_gateway_resource.proxy.id
  http_method     = aws_api_gateway_method.proxy_method.http_method
  type            = "HTTP_PROXY"
  uri             = "http://${var.periodic_table_lb_dns_name}/{proxy+}"
  connection_type = "VPC_LINK"
  connection_id   = var.periodic_table_vpc_link

  depends_on = [aws_api_gateway_method.proxy_method]
}