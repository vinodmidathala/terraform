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

variable "vpc_name" {}
variable "eip_name" {}
variable "igw_name" {}
variable "public_sub2_cidr" {
  description = "CIDR block for public subnet"
}

variable "az_2" { # 👈 fixed name to avoid hyphen issues
  description = "Availability zone for subnets"
}