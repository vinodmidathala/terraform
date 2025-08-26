variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "name" {
  type = string
}

variable "user_data" {}