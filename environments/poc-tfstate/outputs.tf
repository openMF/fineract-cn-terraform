output "bucket-name" {
    value = "${module.tfstate-s3.bucket-name}"
}

output "locktable-name" {
    value = "${module.tfstate-s3.locktable-name}"
}
