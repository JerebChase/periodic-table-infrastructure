resource "aws_apigatewayv2_api" "periodic_table_api" {
  name          = "periodic-table-api-${var.env}"
  protocol_type = "HTTP"

  tags = {
    env = "${var.tag}"
  }
}

resource "aws_apigatewayv2_integration" "ecs_integration" {
  api_id             = aws_apigatewayv2_api.periodic_table_api.id
  integration_type   = "HTTP_PROXY"
  integration_uri    = "http://${var.periodic_table_lb_dns_name}/"
  integration_method = "ANY"
  connection_type    = "VPC_LINK"
  connection_id      = var.periodic_table_vpc_link

  depends_on = [aws_apigatewayv2_api.periodic_table_api]
}

resource "aws_apigatewayv2_route" "proxy_route" {
  api_id    = aws_apigatewayv2_api.periodic_table_api.id
  route_key = "ANY /{proxy+}"
  target    = "integrations/${aws_apigatewayv2_integration.ecs_integration.id}"
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.periodic_table_api.id
  name        = "$default"
  auto_deploy = true
}