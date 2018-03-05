resource "aws_security_group" "wordpress" {
  name = "wordpress"
  description = "Allow connections to Wordpress Instances"
  vpc_id = "${aws_vpc.wordpress.id}"

  tags {
    Name = "Wordpress"
    Group = "Intigral"
  }
}

resource "aws_security_group" "elb" {
  name = "wordpress-elb"
  description = "Allow connections to Wordpress ELB"
  vpc_id = "${aws_vpc.wordpress.id}"

  tags {
    Name = "Wordpress-ELB"
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
  security_group_id = "${aws_security_group.elb.id}"
  type = "ingress"
  protocol = "tcp"
  from_port = 80
  to_port = 80
  cidr_blocks = ["${var.cidr_all}"]
}

resource "aws_security_group_rule" "elb_to_instance_in" {
  security_group_id = "${aws_security_group.wordpress.id}"
  type = "ingress"
  protocol = "tcp"
  from_port = 80
  to_port = 80
  source_security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "wordpress_elb_all_out" {
  security_group_id = "${aws_security_group.elb.id}"
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["${var.cidr_all}"]
}

resource "aws_security_group_rule" "wordpress_ssh_in" {
  security_group_id = "${aws_security_group.wordpress.id}"
  type = "ingress"
  protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_blocks = ["${var.cidr_all}"]
}

