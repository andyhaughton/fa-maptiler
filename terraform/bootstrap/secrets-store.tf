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

# Chamber expects to find a KMS key with alias parameter_store_key in the
# account that you are writing/reading secrets. We set this up as part of
# bootstrap because it needs to persist across environment (re)builds.

resource "aws_kms_key" "parameter_store" {
  description             = "parameter_store_key"
  deletion_window_in_days = 10
  enable_key_rotation     = true

  tags = {
    name = "Parameter Store Key"
  }
}

resource "aws_kms_alias" "parameter_store_alias" {
  name          = "alias/parameter_store_key"
  target_key_id = aws_kms_key.parameter_store.id
}
