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
resource "aws_s3_bucket_object" "ps_cofig" {
  for_each = fileset(path.root, "config/**/*.*")

  bucket = aws_s3_bucket.s3_config.bucket
  key    = each.value
  source = "${path.root}/${each.value}"
}
