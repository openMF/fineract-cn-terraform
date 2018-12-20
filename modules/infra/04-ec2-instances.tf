data "template_file" "user_data" {
    template = "${file("${path.module}/user_data.sh")}"

    vars {
        
    }
}

resource "aws_instance" "infra" {
    instance_type        = "${var.infra_instance_type}"
    ami                  = "${data.aws_ami.infra-ami.id}"
    subnet_id            = "${var.subnet_id}"
    key_name             = "${var.project}-${var.environment}-ssh-key"
    
    vpc_security_group_ids = [
        "${aws_security_group.infra_security_group.id}"
    ]

    user_data = "${data.template_file.user_data.rendered}"

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} infra instance"
        )
    )}"


}
