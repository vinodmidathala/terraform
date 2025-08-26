module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_sub_cidr = var.public_sub_cidr
  prisub_cidr     = var.prisub_cidr
  public_sub2_cidr = var.public_sub2_cidr
  az_1            = var.az_1 
  az_2            = var.az_2# use underscores, not hyphens
  vpc_name        = var.vpc_name
  igw_name        = var.igw_name
  eip_name        = var.eip_name
}

module "jenkins" {
  source             = "./modules/ec2"
  subnet_id          = module.vpc.public_subnet_id[0]
  security_group_ids = [module.vpc.public_sg_id]
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key
  name               = "jenkins"
  user_data = file("userdata/jenkins.sh")
}

module "sonar" {
  source             = "./modules/ec2"
  subnet_id          = module.vpc.public_subnet_id[0]
  security_group_ids = [module.vpc.public_sg_id]
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key
  name               = "sonar"
  user_data = file("userdata/sonar.sh")
}


module "nexus" {
  source             = "./modules/ec2"
  subnet_id          = module.vpc.public_subnet_id[0]
  security_group_ids = [module.vpc.public_sg_id]
  ami                = var.ami
  instance_type      = var.instance_type
  key_name           = var.key
  name               = "nexus"
  user_data = file("userdata/nexus.sh")
}

module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  kubernetes_version = var.kubernetes_version
  node_role_name = var.node_role_name
  cluster_role_name = var.cluster_role_name
  subnet_id = module.vpc.public_subnet_id
  eks_sg_id = module.vpc.public_sg_id
  node_sg_id = module.vpc.public_sg_id
  vpc_id = module.vpc.vpc_id
}