data "aws_caller_identity" "current" {}

resource "aws_iam_role" "ton_lambda_role" {
  name = "ton_lambda_role"

  assume_role_policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ton_lambda_basic_execution" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.ton_lambda_role.name
}

resource "aws_iam_role_policy" "ton_lambda_s3_access" {
  name = "ton_lambda_s3_access"
  role = aws_iam_role.ton_lambda_role.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = [
          "s3:GetObject",
        ]
        Effect   = "Allow"
        Resource = aws_s3_bucket.ton_s3.arn
      }
    ]
  })
}

resource "aws_iam_role_policy" "ton_lambda_dynamodb_access" {
  name = "ton_lambda_dynamodb_access"
  role = aws_iam_role.ton_lambda_role.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action   = [
          "dynamodb:PutItem",
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:Scan"
        ]
        Effect   = "Allow"
        Resource = [
          "${aws_dynamodb_table.ton_dynamodb_visits_table.arn}",
          "${aws_dynamodb_table.ton_dynamodb_users_table.arn}",
          "${aws_dynamodb_table.ton_dynamodb_users_table.arn}/index/*"
        ]
      }
    ]
  })
}

resource "aws_lambda_permission" "ton_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ton_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${local.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.ton_api.id}/*/*"
}
