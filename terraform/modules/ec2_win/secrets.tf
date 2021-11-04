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
 data "aws_ssm_parameter" "ec2_win_maptiler_local_admin_password" {
   name            = "/secrets/ec2_win_maptiler_local_admin_password"
   with_decryption = true # default, but being explicit
 }


