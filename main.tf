terraform {
  required_version = "~> 0.10.7"
}

provider "null" {
  version = "~> 1.0"
}

provider "aws" {
  version = "~> 1.1"

  # Use environment variables for sensitive data:
  # AWS_ACCESS_KEY_ID
  # AWS_SECRET_ACCESS_KEY
  region = "${var.region}"      # or AWS_DEFAULT_REGION
}

locals {
  availability_zones = {
    a = "${var.region}a"
    b = "${var.region}b"
    c = "${var.region}c"
  }

  wordpress_infra_az = "${lookup(local.availability_zones, var.wordpress_infra_az_letter)}"
  elastic_infra_az = "${lookup(local.availability_zones, var.wordpress_infra_az_letter)}"

}

resource "aws_key_pair" "raja" {
  key_name = "${var.raja_key_name}"
  public_key = "${file("${var.raja_public_key_file}")}"
}

