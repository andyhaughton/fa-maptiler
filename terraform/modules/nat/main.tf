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
resource "aws_nat_gateway" "nat" {
  allocation_id = element(aws_eip.eip.*.id, count.index)
  subnet_id     = element(var.subnet_ids, count.index)
  count         = var.subnet_count
  
  tags = {
    Environment = var.environment
    Name = "${var.environment}_nat_gw"
  }
  
}

resource "aws_eip" "eip" {
  vpc   = true
  count = var.subnet_count

  tags = {
    Environment = var.environment
    Name = "${var.environment}_eip"
  }
}

