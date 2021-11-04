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
variable "name" {
  description = "Name of the subnet, actual name will be, for example: name_eu-west2a"
}

variable "environment" {
  description = "The name of the environment"
}

variable "cidrs" {
  type        = list(string)
  description = "List of cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of avalibility zones you want. Example: eu-west2a and eu-west2b"
}

variable "vpc_id" {
  description = "VPC id to place to subnet into"
}

