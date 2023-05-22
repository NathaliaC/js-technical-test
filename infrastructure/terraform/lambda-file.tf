data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../.."
  output_path = "${path.module}/../../${local.lambda_file_name}.zip"

  excludes = [
    ".git",
    ".gitignore",
    "README.md",
    "infrastructure",
    "Makefile"
  ]
}

resource "aws_s3_bucket_object" "ton_lambda_file" {
  depends_on = [aws_s3_bucket.ton_s3]
  bucket     = aws_s3_bucket.ton_s3.id
  key        = "${local.common_tags.App}/${local.lambda_file_name}.zip"
  source     = data.archive_file.lambda_zip.output_path
}
