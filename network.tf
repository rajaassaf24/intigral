resource "aws_vpc" "wordpress" {
  cidr_block = "${var.wordpress_vpc_cidr}"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_classiclink = false

  tags {
    Name = "WordpressVPC"
    Group = "Intigral"
  }
}

locals {
  wordpress_cidr = "${cidrsubnet("${aws_vpc.wordpress.cidr_block}", 4, 0)}"
}

resource "aws_subnet" "wordpress" {
  vpc_id = "${aws_vpc.wordpress.id}"
  cidr_block = "${local.wordpress_cidr}"
  availability_zone = "${local.wordpress_infra_az}"

  tags {
    Name = "WordpressSubnet"
    Group = "Intigral"
  }
}

resource "aws_internet_gateway" "wordpress" {
  vpc_id = "${aws_vpc.wordpress.id}"

  tags {
    Name = "WordpressGW"
    Group = "Intigral"
  }
}

resource "aws_route_table" "wordpress" {
  vpc_id = "${aws_vpc.wordpress.id}"
  tags {
    Name = "WordpressRT"
    Group = "Intigral"
  }
}

resource "aws_route" "wordpress" {
  route_table_id = "${aws_route_table.wordpress.id}"
  gateway_id = "${aws_internet_gateway.wordpress.id}"
  destination_cidr_block = "${var.cidr_all}"
  depends_on = ["aws_route_table.wordpress"]
}

resource "aws_route_table_association" "wordpress" {
  subnet_id = "${aws_subnet.wordpress.id}"
  route_table_id = "${aws_route_table.wordpress.id}"
}
