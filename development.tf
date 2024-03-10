resource "random_id" "random_id_prefix" {
  byte_length = 2
}

locals {
  production_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "Myvpc" {
  source               = "./module/vpc"
  region               = var.region
  environment          = var.environment
  cidr_block           = var.cidr_block
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.production_availability_zones

}
 #module "zomato" {
  #  source                     = "./module/ec2"
  # ami                        = var.ami
  #  instance_type              = var.instance_type
  #  key_name                   = var.key_name
  #  subnet_id                  = module.Myvpc.public_subnets_id[0]
  #  default_security_group_ids = module.Myvpc.default_security_group_ids
  #}

module "eks_cluster" {
  source          = "./module/eks"

  cluster_name    = var.cluster_name

  

  subnet_ids      = module.Myvpc.public_subnets_id[0]

  default_security_group_ids = module.Myvpc.default_security_group_ids

  instance_type   = var.instance_type  # Adjust instance type as per your requirements

  desired_capacity = 2

  min_size         = 1

  max_size         = 3
  #ami_type         = "AL2_x86_64"
}

module "ecr" {
    source               = "./module/ecr"
    environment          = var.environment
    project              = var.project 
    ecr_name             = var.ecr_name
    tags                 = var.tags
    image_tag_mutability = var.image_mutability

  
}

