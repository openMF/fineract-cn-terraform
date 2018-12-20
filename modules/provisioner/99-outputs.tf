output "provisioner_private_ip" {
    value = "${aws_instance.provisioner.private_ip}"
}

output "provisioner_security_group_id" {
    value = "${aws_security_group.provisioner_security_group.id}"
}
