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
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true

  # if we destroy the VPC we need to set up ZScaler peering again
  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = var.environment
    Environment = var.environment
  }
}

resource "aws_internet_gateway" "vpc" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name        = var.environment
    Environment = var.environment
  }
}
