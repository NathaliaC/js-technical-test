# API Gateway REST API
resource "aws_api_gateway_rest_api" "ton_api" {
  name = local.api_gateway_name
  tags = local.common_tags
}

# API Gateway Methods
resource "aws_api_gateway_method" "ton_methods" {
  for_each = local.methods

  rest_api_id   = aws_api_gateway_rest_api.ton_api.id
  resource_id   = each.value.resource_id
  http_method   = each.value.http_method
  authorization = "NONE"
}

# API Gateway Integrations
resource "aws_api_gateway_integration" "ton_integrations" {
  for_each = local.methods

  rest_api_id             = aws_api_gateway_rest_api.ton_api.id
  resource_id             = each.value.resource_id
  http_method             = each.value.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.ton_lambda.invoke_arn
}

# API Gateway Deployment
resource "aws_api_gateway_deployment" "ton_deployment" {
  depends_on = [
    aws_api_gateway_integration.ton_integrations
  ]

  rest_api_id = aws_api_gateway_rest_api.ton_api.id
  stage_name  = "prod"
}
