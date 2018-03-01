resource "aws_security_group" "rds" {
  name = "rds"
  description = "Allow connections to rds from wordpress Instances"
  vpc_id = "${aws_vpc.wordpress.id}"
# keeping the instances and RDS on the same vpc. Can configure different vpc and# use vpc peering see "https://www.terraform.io/docs/providers/aws/r/vpc_peering.html" for more details
  tags {
    Name = "RDS"
    Group = "Intigral"
  }
}

resource "aws_db_subnet_group" "rds" {
  name = "rds"
  subnet_ids = ["${aws_subnet.wordpress.id}","${aws_subnet.rds.id}"]

  tags {
    Name = "RDS DB subnet"
    Group = "Intigral"
  }
}

resource "aws_security_group_rule" "rds_wordpress_in" {
  security_group_id = "${aws_security_group.rds.id}"
  type = "ingress"
  protocol = "tcp"
  from_port = 3306 
  to_port = 3306
  source_security_group_id = "${aws_security_group.wordpress.id}"
}

resource "aws_security_group_rule" "rds_wordpress_out" {
  security_group_id = "${aws_security_group.rds.id}"
  type = "egress"
  protocol = "tcp"
  from_port = 3306
  to_port = 3306
  source_security_group_id = "${aws_security_group.wordpress.id}"
}

resource "aws_db_instance" "rds" {
  identifier = "raja"
  allocated_storage = "10"
  engine = "mysql"
  engine_version = "5.6.37"
  instance_class = "db.t2.micro"
  availability_zone = "${local.rds_infra_az}"
  skip_final_snapshot = "true"
  multi_az = "false"
  name = "wordpress"
  username = "wordpress"
  password = "password"
  vpc_security_group_ids = ["${aws_security_group.rds.id}"]
  db_subnet_group_name = "${aws_db_subnet_group.rds.id}"

  tags {
    Name = "WordpressRDS"
    Group = "Integral"
  }
}
