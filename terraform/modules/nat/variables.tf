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
variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets in which to place the NAT Gateway"
}

variable "subnet_count" {
  description = "Size of the subnet_ids. This needs to be provided because: value of 'count' cannot be computed"
}

variable "environment" {}
