terraform {
  backend "remote" {
    organization = "jeremy-chase-brown"

    workspaces {
      name = "periodic-table-infrastrucutre"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0" # Adjust the version if needed
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "ecr" {
  source = "./modules/ecr"
}

module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source = "./modules/iam"
}

module "ecs" {
  source                = "./modules/ecs"
  ecs_role_arn          = module.iam.ecs_role_arn
  ecr_repository_url    = module.ecr.ecr_repository_url
  periodic_table_subnet = module.vpc.periodic_table_subnet
  periodic_table_sg     = module.vpc.periodic_table_sg
}

module "autoscaling" {
  source                 = "./modules/autoscaling"
  periodic_table_cluster = module.ecs.periodic_table_cluster
  periodic_table_service = module.ecs.periodic_table_service
}

module "vpclink" {
  source                     = "./modules/vpclink"
  periodic_table_service_arn = module.ecs.periodic_table_service_arn
}

module "apigw" {
  source                  = "./modules/apigw"
  periodic_table_vpc_link = module.vpclink.periodic_table_vpc_link
}

module "cloudfornt" {
  source             = "./modules/cloudfront"
  periodic_table_api = module.apigw.periodic_table_api
}