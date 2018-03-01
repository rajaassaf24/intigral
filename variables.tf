variable "cidr_all" {
  default = "0.0.0.0/0"
}
variable "raja_private_key_file" {}

variable "raja_public_key_file" {}

variable "raja_key_name" {
  type = "string"
  default = "raja-key"
}

variable "region" {
  default = "us-east-1"
}

variable "wordpress_infra_az_letter" {
  type = "string"
  default = "b"
}

variable "rds_infra_az_letter" {
  type = "string"
  default = "a"
}

variable "elastic_infra_az_letter" {
  type = "string"
  default = "c"
}

variable "wordpress_vpc_cidr" {
  type = "string"
  default =  "192.168.0.0/16"
}

variable "elastic_vpc_cidr" {
  type = "string"
  default = "10.0.0.0/16"
}

variable "count_wordpress" {
  default = "1"
  description = "number of wordpress instances to launch"
}

variable "count_elastic" {
  default = "1"
  description = "number of elastic instances to launch"
}

variable "es_domain" {
  default = "enter domain name here"
}

variable "es_version" {
  default = "enter elasticsearch version here"
}

variable "es_type" {
  default = "enter es instance type here"
}

variable "es_allow_explicit_indes" {
  default = "true or false"
}

variable "es_policy" {
  description = "List of IAM role ARNs from which to permit traffic (default ['*']).  Note that a client must match both the IP address and the IAM role patterns in order to be permitted access."
  type        = "list"
  default     = ["*"]
}

variable "es_snapshot_hour" {
  default = "enter here the hour at which snapshots should occur"
}
