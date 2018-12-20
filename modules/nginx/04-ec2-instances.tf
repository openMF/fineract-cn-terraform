data "template_file" "user_data" {
    template = "${file("${path.module}/user_data.sh")}"

    vars {
        
    }
}

resource "aws_instance" "nginx" {
    count = "${var.nginx_instance_count}"
    
    instance_type = "${var.nginx_instance_type}"
    ami           = "${data.aws_ami.nginx-ami.id}"
    subnet_id     = "${element(var.subnet_ids, count.index)}"
    key_name      = "${var.project}-${var.environment}-ssh-key"

    vpc_security_group_ids = [
        "${aws_security_group.nginx_security_group.id}"
    ]

    user_data = "${data.template_file.user_data.rendered}"

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} nginx instance #${count.index}"
        )
    )}"
}
