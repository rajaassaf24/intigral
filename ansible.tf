resource "null_resource" "wordpress" {    
    
  triggers {
    group = "wordpress"
    host = "wordpress-${aws_instance.wordpress.id}"

    host_var_internal_ip = "${aws_instance.wordpress.private_ip}"
    host_var_ansible_host = "${aws_instance.wordpress.public_ip}"
  }

}

output "wordpress" {
  value = ["${null_resource.wordpress.*.triggers}"]
}
