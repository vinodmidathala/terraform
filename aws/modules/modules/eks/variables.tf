variable "cluster_name" {}
variable "kubernetes_version" {}
variable "node_role_name" {}
variable "cluster_role_name" {}
variable "subnet_id" {
  type = list(string)
}
variable "eks_sg_id" {}
variable "node_sg_id" {}
variable "vpc_id" {}