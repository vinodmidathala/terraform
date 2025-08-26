variable "region" {
  description = "AWS region for deployment"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
}

variable "public_sub_cidr" {
  description = "CIDR block for public subnet"
}

variable "az_1" { # 👈 fixed name to avoid hyphen issues
  description = "Availability zone for subnets"
}

variable "prisub_cidr" {
  description = "CIDR block for private subnet"
}

variable "instance_type" {}
variable "instance_name" {}
variable "key" {}
variable "ami" {}