resource "null_resource" "wordpress" {    
    
  triggers {
    host_id = "${join(",", aws_instance.wordpress.*.id)}"
    group = "wordpress"
    host_var_internal_ip = "${join(",", aws_instance.wordpress.*.private_ip)}"
    host = "${join(",", aws_instance.wordpress.*.public_ip)}"
  }

}

output "wordpress" {
  value = ["${null_resource.wordpress.*.triggers}"]
}

resource "null_resource" "rds" {
  triggers {
    endpoint = "${aws_db_instance.rds.endpoint}"
}
}
output "rds" {
  value = ["${null_resource.rds.*.triggers}"]
}
