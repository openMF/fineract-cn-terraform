output "bucket-name" {
    value = "${aws_s3_bucket.tfstate-bucket.bucket}"
}

output "locktable-name" {
    value = "${aws_dynamodb_table.tfstate-lock.name}"
}
