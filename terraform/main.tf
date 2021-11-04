###################################################################################
#                                                                                 #
# Copyright 2015-2021 Forensic Analytics Limited. All rights reserved.            #
#                                                                                 #
# If you wish to use this software or any part of it for any purpose, you require #
#                                                                                 #
# an express licence given in writing by Forensic Analytics Limited.              #
#                                                                                 #
# Visit forensicanalytics.co.uk                                                   #
#                                                                                 #
###################################################################################

# See ./bootstrap
terraform {
  backend "s3" {
    bucket         = "fa-tfstate"
    key            = "fa.tfstate"
    dynamodb_table = "fa-tfstate-lock"
    region         = "eu-west-2" # Terraform should support variables here
  }
}

# check the terraform workspace matches the .tfvars file
# (minimise blast radius - would be Very Bad to accidentally deploy dev config
# against production)
# see https://www.terraform.io/docs/configuration-0-11/interpolation.html#conditionals for syntax


# https://en.wikipedia.org/wiki/Don%27t_repeat_yourself
# Need to use locals as Terraform seemingly doesn't support merging two vars into new var
locals {
  environment = "${var.project}-${var.env_tla}"
}

resource "aws_key_pair" "shared_ec2_key" {
  key_name   = "fa-maptiler-Key"
  public_key = file("./pubkeys/${local.environment}.pub")
}

module "network" {
  source               = "./modules/network"
  availability_zones   = var.availability_zones
  environment          = local.environment
  project              = var.project
  private_subnet_cidrs = var.private_subnet_cidrs
  public_subnet_cidrs  = var.public_subnet_cidrs
  region               = var.region
  vpc_cidr             = var.vpc_cidr
}

module "ec2_linux" {
  source             = "./modules/ec2_linux"
  ami_id             = var.ec2_linux_ami
  environment        = local.environment
  instance_type      = var.ec2_linux_instance_type
  key_name           = aws_key_pair.shared_ec2_key.key_name
  public_ip          = true
  s3_admin_accesskey = module.iam_s3admin.access_key
  ssm_param_rw_accesskey = module.iam_ssm.access_key
  sg_allowed_cidrs   = var.all_subnet_cidrs
  sg_allowed_subnet  = var.vpc_subnet
  subnet_ids         = module.network.public_subnet_ids
  vpc_id             = module.network.vpc_id
  
}

module "ec2_win" {
  source             = "./modules/ec2_win"
  ami_id             = var.ec2_win_ami
  environment        = local.environment
  instance_type      = var.ec2_win_instance_type
  key_name           = aws_key_pair.shared_ec2_key.key_name
  public_ip          = true
  s3_admin_accesskey = module.iam_s3admin.access_key
  ssm_param_rw_accesskey = module.iam_ssm.access_key
  sg_allowed_cidrs   = var.all_subnet_cidrs
  sg_allowed_subnet  = var.vpc_subnet
  subnet_ids         = module.network.public_subnet_ids
  vpc_id             = module.network.vpc_id
  
}

module "s3_config" {
  source            = "./modules/s3_config"
  environment       = local.environment

}

module "iam_s3admin" {
  source = "./modules/iam_s3admin"
  region = var.region
}

module "iam_ssm" {
  source = "./modules/iam_ssm"
  region = var.region
}

