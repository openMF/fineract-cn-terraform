resource "aws_s3_bucket" "tfstate-bucket" {
    bucket = "${var.project}-${var.environment}-tfstate"

    versioning {
        enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }

    tags {
        environment = "${var.environment}"
        project = "${var.project}"
    }
}

resource "aws_dynamodb_table" "tfstate-lock" {
    name = "${var.project}-${var.environment}-tfstate-lock"
    
    hash_key = "LockID"
    read_capacity = 5
    write_capacity = 5

    attribute {
        name = "LockID"
        type = "S"
    }

    tags {
        environment = "${var.environment}"
        project = "${var.project}"
    }
}
