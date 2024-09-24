terraform {
  cloud {
    organization = "jeremy-chase-brown"

    workspaces {
      name = "periodic-table-infrastructure"
    }
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
}

module "ecr" {
  source = "./modules/ecr"
  tag    = local.aws_tag
}

module "vpc" {
  source = "./modules/vpc"
  tag    = local.aws_tag
}

module "iam" {
  source = "./modules/iam"
  tag    = local.aws_tag
}

module "ecs" {
  source                = "./modules/ecs"
  ecs_role_arn          = module.iam.ecs_role_arn
  ecr_repository_url    = module.ecr.ecr_repository_url
  periodic_table_subnet = module.vpc.periodic_table_subnet
  periodic_table_sg     = module.vpc.periodic_table_sg
  tag                   = local.aws_tag
}

module "autoscaling" {
  source                 = "./modules/autoscaling"
  periodic_table_cluster = module.ecs.periodic_table_cluster
  periodic_table_service = module.ecs.periodic_table_service
  tag                    = local.aws_tag
}

module "vpclink" {
  source                     = "./modules/vpclink"
  periodic_table_service_arn = module.ecs.periodic_table_service_arn
  tag                        = local.aws_tag
}

module "apigw" {
  source                  = "./modules/apigw"
  periodic_table_vpc_link = module.vpclink.periodic_table_vpc_link
  tag                     = local.aws_tag
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  periodic_table_api = module.apigw.periodic_table_api
  tag                = local.aws_tag
}