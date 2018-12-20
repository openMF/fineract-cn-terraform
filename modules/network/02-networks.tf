data "aws_availability_zones" "available" {}

locals {
    az_count = "${length(data.aws_availability_zones.available.names)}"
}

resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr_block}"

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} VPC"
        )
    )}"
}

resource "aws_subnet" "public" {
    count                   = "${local.az_count}"
    vpc_id                  = "${aws_vpc.vpc.id}"
    availability_zone       = "${element(data.aws_availability_zones.available.names, count.index)}"
    cidr_block              = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)}"
    
    
    map_public_ip_on_launch = true

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} public subnet in ${data.aws_availability_zones.available.names[count.index]}",
        )
    )}"
}

resource "aws_subnet" "private" {
    count             = "${local.az_count}"
    vpc_id            = "${aws_vpc.vpc.id}"
    availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"
    cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, local.az_count+count.index)}"
    
    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} private subnet in ${data.aws_availability_zones.available.names[count.index]}",
        )
    )}"
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.vpc.id}"

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} internet gateway"
        )
    )}"
}

resource "aws_route_table" "public_rt" {
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.igw.id}"
    }

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} public route table"
        )
    )}"
}

resource "aws_route_table_association" "rta-public" {
    count          = "${local.az_count}"
    subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
    route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_eip" "ngw_eip" {
    count = "${local.az_count}"
    vpc   = true

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} NAT gateway EIP in ${data.aws_availability_zones.available.names[count.index]}"
        )
    )}"   
    
    depends_on = [ "aws_internet_gateway.igw" ]
}

resource "aws_nat_gateway" "ngw" {
    count         = "${local.az_count}"
    allocation_id = "${element(aws_eip.ngw_eip.*.id, count.index)}"
    subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
    
    depends_on = [ "aws_internet_gateway.igw" ]

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} NAT gateway in ${data.aws_availability_zones.available.names[count.index]}"
        )
    )}"
}

resource "aws_route_table" "private_rt" {
    count  = "${local.az_count}"
    vpc_id = "${aws_vpc.vpc.id}"

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = "${element(aws_nat_gateway.ngw.*.id, count.index)}"
    }

    tags = "${merge(
        local.common_tags,
        map(
            "Name", "${var.project}-${var.environment} private route table"
        )
    )}"
}

resource "aws_route_table_association" "rta-private" {
    count          = "${local.az_count}"
    subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
    route_table_id = "${element(aws_route_table.private_rt.*.id, count.index)}"
}
