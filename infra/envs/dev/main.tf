terraform {
  backend "s3" {
    bucket         = "osmanolad-tf-state"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "ecs-terraform-state-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source       = "../../modules/vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
}

module "database" {
  source       = "../../modules/database"
  project_name = var.project_name
}

module "alb" {
  source            = "../../modules/alb"
  project_name      = var.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
}

module "ecs" {
  source                  = "../../modules/ecs"
  project_name            = var.project_name
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnet_ids
  target_group_arn        = module.alb.target_group_arn
  alb_security_group_id   = module.alb.alb_security_group_id
  dynamodb_table_arn      = module.database.table_arn
  target_group_name       = module.alb.target_group_name
  green_target_group_name = module.alb.green_target_group_name
  prod_listener_arn       = module.alb.prod_listener_arn
  test_listener_arn       = module.alb.test_listener_arn
} 

module "ecr" {
  source       = "../../modules/ecr"
  project_name = var.project_name
}

module "waf" {
  source       = "../../modules/waf"
  project_name = var.project_name
  alb_arn      = module.alb.alb_arn
}
