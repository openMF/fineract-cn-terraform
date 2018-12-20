resource "aws_db_subnet_group" "mariadb-subnet" {
    name        = "${var.project}-${var.environment}-mariadb-subnet"
    description = "${var.project}-${var.environment} mariadb subnet"
    subnet_ids  = [ "${var.subnet_ids}" ]
}

resource "aws_db_instance" "mariadb" {
    engine              = "mariadb"
    engine_version      = "10.3.8"
    instance_class      = "${var.mariadb_instance_type}"
    storage_type        = "gp2"
    allocated_storage   = "${var.mariadb_size}"
    storage_encrypted   = false
    apply_immediately   = true
    publicly_accessible = false
    skip_final_snapshot = true
    
    db_subnet_group_name = "${aws_db_subnet_group.mariadb-subnet.name}"
    vpc_security_group_ids = [ "${aws_security_group.mariadb_security_group.id}" ]
    
    identifier = "${var.project}-${var.environment}"
    name       = "${var.project}${var.environment}" // can't use a more meaningful name

    username = "${var.mariadb_admin_user}"
    password = "${var.mariadb_admin_password}"

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} mariadb database"
        )
    )}"
}
