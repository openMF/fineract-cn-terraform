resource "aws_elb" "nginx_elb" {
    name = "${var.project}-${var.environment}-nginx-elb"
    security_groups = [
        "${aws_security_group.elb_security_group.id}"
    ]
    subnets = [ "${var.subnet_ids}" ]
    
    cross_zone_load_balancing = true
    instances = [
        "${aws_instance.nginx.*.id}"
    ]

    listener {
        lb_port = 80
        lb_protocol = "http"
        instance_port = 80
        instance_protocol = "http"
        // ssl_certificate_id = ""
    }

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} nginx load-balancer"
        )
    )}"
  
}

resource "aws_lb_cookie_stickiness_policy" "default" {
    name = "${var.project}-${var.environment}-lbpolicy"
    load_balancer = "${aws_elb.nginx_elb.id}"
    lb_port = 80
    cookie_expiration_period = 86400
}
