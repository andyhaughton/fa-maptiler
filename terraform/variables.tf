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

variable "dns_ips" {
  type = list(string)
}

variable "availability_zones" {
  type        = list(string)
  description = "List of avalibility zones you want. Example: eu-west2a and eu-west2b"
}

variable "ec2_linux_ami" {
  type = string
}

variable "ec2_win_ami" {
  type = string
}

variable "ec2_linux_instance_type" {
  type = string
}

variable "ec2_win_instance_type" {
  type = string
}

variable "env_tla" {
  description = "TLA for the environment - one of dev, tst, prd"
}

variable "project" {
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "all_subnet_cidrs" {
  type        = list(string)
  description = "List of all cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "region" {
  description = "AWS Region Name"
}

variable "vpc_cidr" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
}

variable "vpc_subnet" {
}


