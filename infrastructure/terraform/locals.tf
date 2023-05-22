locals {
    common_tags = {
        App = "js-technical-test"
        Name = "js-technical-test",
        Company = "stone"
        Owner = "nathalia.chavez"
    }

    aws_region = "us-east-2"

    lambda_file_name = "lambda_function"
    s3_bucket_name = "js-technical-test"
    lambda_name ="ton-lambda-test"
    api_gateway_name = "ton-api-test"
}
