#resource "aws_elasticsearch_domain" "es" {
#  domain_name           = "${var.es_domain}"
#  elasticsearch_version = "${var.es_version}"
#  cluster_config {
#    instance_type = "${var.es_type}"
#    instance_count = "${var.count_elastic}"
#  }
#
#  advanced_options {
#    "rest.action.multi.allow_explicit_index" = "${var.es_allow_explicit_index}"
#  }
#
#  access_policies = <<CONFIG
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Action": "es:*",
#            "Principal": "*",
#            "Effect": "Allow",
#            "Condition": {
#                "IpAddress": {"aws:SourceIp": ["${var.wordpress_vpc_cidr}"]}
#            }
#        }
#    ]
#} 
#CONFIG
#  ebs_options {
#    ebs_enabled = "true"
#    volume_size = "10"
#}
#  snapshot_options {
#    automated_snapshot_start_hour = "${var.es_snapshot_hour}"
#  }
#
#  tags {
#    Domain = "Intigral"
#  }
#}
