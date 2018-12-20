output "nginx_elb_dns_name" {
    value = "${aws_elb.nginx_elb.dns_name}"
}

output "nginx_private_ips" {
    value = "${aws_instance.nginx.*.private_ip}"
}

output "nginx_security_group_id" {
    value = "${aws_security_group.nginx_security_group.id}"
}