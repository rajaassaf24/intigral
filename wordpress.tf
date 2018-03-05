resource "aws_instance" "wordpress" {
  count = "${var.count_wordpress}"
  ami = "ami-0dc82b70"
  associate_public_ip_address = "true"
  availability_zone = "${local.wordpress_infra_az}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.raja.key_name}"
  vpc_security_group_ids = ["${aws_security_group.wordpress.id}"]
  subnet_id = "${aws_subnet.wordpress.id}"

  tags {
    Name = "WordpressEC2-${count.index}"
    Group = "Integral"
  }
}
