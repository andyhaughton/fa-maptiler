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


###############################################################################
## Environment Common
###############################################################################

env_tla = "maptiler" // MUST be changed for tst & prd

region = "eu-west-2"

project = "fa"

###############################################################################
## Networking
###############################################################################

vpc_cidr = "172.30.0.0/16"
vpc_subnet = "172.30.0.0/16"

all_subnet_cidrs = [
  "172.30.0.0/17",
  "172.30.128.0/17"
]

private_subnet_cidrs = [
  "172.30.16.0/20",
  "172.30.32.0/20"
]

public_subnet_cidrs = [
  "172.30.64.0/20",
  "172.30.96.0/20"
]

availability_zones = [
  "eu-west-2a",
  "eu-west-2b",
]

dns_ips = [
  "8.8.8.8",
  "8.8.4.4",
]


###############################################################################
## EC2 WIN
###############################################################################

ec2_win_instance_type = "t3.large"
ec2_win_ami           = "ami-0f34584723e6f6fa9" 

############################################################################
## EC2 LINUX
############################################################################

ec2_linux_instance_type = "t3.large"
ec2_linux_ami           = "ami-0edce2238602f63eb" 


