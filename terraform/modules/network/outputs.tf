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
output "vpc_id" {
  value = module.vpc.id
}

output "vpc_cidr" {
  value = module.vpc.cidr_block
}

 output "private_subnet_ids" {
  value = module.private_subnet.ids
}


 output "public_subnet_ids" {
  value = module.public_subnet.ids
}

 output "private_subnet_route_table_ids" {
  value = module.private_subnet.route_table_ids
 }




