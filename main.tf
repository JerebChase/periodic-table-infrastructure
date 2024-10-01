terraform {
  cloud {
    organization = "jeremy-chase-brown"
  }
}

locals {
  aws_tag = "periodic-table-${var.env}"
}

provider "aws" {
  region = "us-east-1"
}

module "rg" {
  source = "./modules/rg"
  tag    = local.aws_tag
  env    = var.env
}

module "ecr" {
  source = "./modules/ecr"
  tag    = local.aws_tag
  env    = var.env
}

module "vpc" {
  source = "./modules/vpc"
  tag    = local.aws_tag
}

module "iam" {
  source = "./modules/iam"
  tag    = local.aws_tag
  env    = var.env
}

module "ecs" {
  source                = "./modules/ecs"
  ecs_role_arn          = module.iam.ecs_role_arn
  ecr_repository_url    = module.ecr.ecr_repository_url
  periodic_table_subnet = module.vpc.periodic_table_subnet
  periodic_table_sg     = module.vpc.periodic_table_sg
  tag                   = local.aws_tag
  env                   = var.env
}

module "autoscaling" {
  source                 = "./modules/autoscaling"
  periodic_table_cluster = module.ecs.periodic_table_cluster
  periodic_table_service = module.ecs.periodic_table_service
  tag                    = local.aws_tag
  env                    = var.env
}

module "nlb" {
  source                = "./modules/nlb"
  periodic_table_vcp_id = module.vpc.periodic_table_vpc_id
  periodic_table_subnet = module.vpc.periodic_table_subnet
  tag                   = local.aws_tag
  env                   = var.env
}

module "vpclink" {
  source                = "./modules/vpclink"
  periodic_table_lb_arn = module.nlb.periodic_table_lb_arn
  tag                   = local.aws_tag
  env                   = var.env
}

module "apigw" {
  source                  = "./modules/apigw"
  periodic_table_vpc_link = module.vpclink.periodic_table_vpc_link
  tag                     = local.aws_tag
  env                     = var.env
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  periodic_table_api = module.apigw.periodic_table_api
  tag                = local.aws_tag
  env                = var.env
}