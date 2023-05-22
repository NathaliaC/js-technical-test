resource "aws_lambda_function" "ton_lambda" {
  depends_on = [aws_s3_bucket.ton_s3, aws_s3_bucket_object.ton_lambda_file]
  function_name = local.lambda_name
  handler       = "src/index.handler"
  runtime       = "nodejs18.x"
  timeout       = 8
  

  role       = aws_iam_role.ton_lambda_role.arn
  s3_bucket  = aws_s3_bucket.ton_s3.id
  s3_key     = "${local.common_tags.App}/${local.lambda_file_name}.zip"
  tags       = local.common_tags
  }
