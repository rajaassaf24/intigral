resource "aws_security_group" "wordpress" {
  name = "wordpress"
  description = "Allow connections to Wordpress Instances"
  vpc_id = "${aws_vpc.wordpress.id}"

  tags {
    Name = "Wordpress"
    Group = "Intigral"
  }
}

resource "aws_security_group_rule" "wordpress_all_out" {
  security_group_id = "${aws_security_group.wordpress.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${var.cidr_all}"]
}

resource "aws_security_group_rule" "wordpress_same_group_all_in" {
  security_group_id = "${aws_security_group.wordpress.id}"
  type = "ingress"
  self = true
  protocol = "-1"
  from_port = 0
  to_port = 0
}

resource "aws_security_group_rule" "wordpress_same_group_all_out" {
  security_group_id = "${aws_security_group.wordpress.id}"
  type = "egress"
  self = true
  protocol = "-1"
  from_port = 0
  to_port = 0
}

resource "aws_security_group_rule" "wordpress_http_in" {
  security_group_id = "${aws_security_group.wordpress.id}"
  type = "ingress"
  protocol = "tcp"
  from_port = 80
  to_port = 80
  cidr_blocks = ["${var.cidr_all}"]
}

resource "aws_security_group_rule" "wordpress_https_in" {
  security_group_id = "${aws_security_group.wordpress.id}"
  type = "ingress"
  protocol = "tcp"
  from_port = 443
  to_port = 443
  cidr_blocks = ["${var.cidr_all}"]
}
resource "aws_instance" "wordpress" {
  count = "${var.count_wordpress}"
  ami = "ami-638b6375"
  associate_public_ip_address = "true"
  availability_zone = "${local.wordpress_infra_az}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.raja.key_name}"
  vpc_security_group_ids = ["${aws_security_group.wordpress.id}"]
  subnet_id = "${aws_subnet.wordpress.id}"

  tags {
    Name = "WordpressEC2"
    Group = "Integral"
  }
}
