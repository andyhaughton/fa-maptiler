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
variable "environment" {
  description = "The name of the environment"
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  description = "EC2 instance type for server"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the server"
  type        = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "sg_allowed_cidrs" {
  type = list(string)
}

variable "vpc_id" {
  description = "The VPC id"
}



# whether to allocate a public IP (temporary testing workaround)
variable "public_ip" {
  default = false
}


variable "sg_allowed_subnet" {}


variable "s3_admin_accesskey" {
  description = "Map of s3_admin access key ID and secret"
}

variable "ssm_param_rw_accesskey" {
  description = "Map of ssm_param_rw access key ID and secret"
}




