resource "aws_iam_role" "eks_cluster_role" {
  name = var.cluster_role_name
  assume_role_policy = <<POLICY
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "aws_eks_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster_role.id
}

resource "aws_eks_cluster" "eks_cluster-1" {
  name = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version = var.kubernetes_version

  vpc_config {
    security_group_ids = [var.eks_sg_id]
    subnet_ids = var.subnet_id
    endpoint_public_access = true
 }

depends_on = [aws_iam_role_policy_attachment.aws_eks_role_policy]
}




resource "aws_iam_role" "eks_node_role" {
  name = var.node_role_name
  assume_role_policy = <<POLICY
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}