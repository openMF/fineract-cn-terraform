output "infra_private_ip" {
    value = "${aws_instance.infra.private_ip}"
}

output "infra_security_group_id" {
    value = "${aws_security_group.infra_security_group.id}"
}

output "cassandra_listening_address" {
    value = "${aws_instance.infra.private_ip}:9042"
}

output "kafka_listening_address" {
    value = "${aws_instance.infra.private_ip}:9092"
}

output "eureka_listening_url" {
    value = "http://${aws_instance.infra.private_ip}:8080/eureka/"
}