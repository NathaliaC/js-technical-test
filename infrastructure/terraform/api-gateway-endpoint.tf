# API Gateway Resources
resource "aws_api_gateway_resource" "ton_user_id" {
  rest_api_id = aws_api_gateway_rest_api.ton_api.id
  parent_id   = aws_api_gateway_resource.ton_user.id
  path_part   = "{user_id}"
}

resource "aws_api_gateway_resource" "ton_user" {
  rest_api_id = aws_api_gateway_rest_api.ton_api.id
  parent_id   = aws_api_gateway_rest_api.ton_api.root_resource_id
  path_part   = "users"
}

resource "aws_api_gateway_resource" "ton_authentication" {
  rest_api_id = aws_api_gateway_rest_api.ton_api.id
  parent_id   = aws_api_gateway_rest_api.ton_api.root_resource_id
  path_part   = "authentication"
}

resource "aws_api_gateway_resource" "ton_visits" {
  rest_api_id = aws_api_gateway_rest_api.ton_api.id
  parent_id   = aws_api_gateway_rest_api.ton_api.root_resource_id
  path_part   = "visits"
}

# Local variables for methods
locals {
  methods = {
    # {user_id} resource
    get_user_by_id = {
      resource_id = aws_api_gateway_resource.ton_user_id.id
      http_method = "GET"
    },
    # users resource
    get_user = {
      resource_id = aws_api_gateway_resource.ton_user.id
      http_method = "GET"
    },
    post_user = {
      resource_id = aws_api_gateway_resource.ton_user.id
      http_method = "POST"
    },
    # authentication resource
    post_authentication = {
      resource_id = aws_api_gateway_resource.ton_authentication.id
      http_method = "POST"
    },
    # visits resource
    ton_get = {
      resource_id = aws_api_gateway_resource.ton_visits.id
      http_method = "GET"
    },
    ton_patch = {
      resource_id = aws_api_gateway_resource.ton_visits.id
      http_method = "PATCH"
    },
  }
}
