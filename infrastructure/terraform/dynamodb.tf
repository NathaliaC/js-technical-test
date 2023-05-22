resource "aws_dynamodb_table" "ton_dynamodb_users_table" {
    name           = "ton-dynamodb-users-table"
    tags           = local.common_tags
    billing_mode   = "PROVISIONED"
    read_capacity  = 10
    write_capacity = 10
    hash_key       = "uuid"

    attribute {
        name = "uuid"
        type = "S"
    }

    attribute {
        name = "email"
        type = "S"
    }

    global_secondary_index {
        name               = "email-index"
        hash_key           = "email"
        projection_type    = "ALL"
        read_capacity      = 10
        write_capacity     = 10
    }
}

resource "aws_dynamodb_table" "ton_dynamodb_visits_table" {
    name           = "ton-dynamodb-visits-table"
    tags           = local.common_tags
    billing_mode   = "PROVISIONED"
    read_capacity  = 10
    write_capacity = 10
    hash_key       = "id"

    attribute {
        name = "id"
        type = "S"
    }
}
