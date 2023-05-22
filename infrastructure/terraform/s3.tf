resource "aws_s3_bucket" "ton_s3"{
    bucket = local.s3_bucket_name
    tags   = local.common_tags
    acl    = "private"
    
    versioning {
        enabled = false
    }

    server_side_encryption_configuration {
      rule {
          apply_server_side_encryption_by_default {
              sse_algorithm = "aws:kms"
          }
      }
    }

    force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "ton-s3" {
    bucket                  = aws_s3_bucket.ton_s3.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}
