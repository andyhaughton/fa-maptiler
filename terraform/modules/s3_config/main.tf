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
resource "aws_s3_bucket" "s3_config" {

tags = {
    Environment = var.environment
  }

  # only lowercase alphanumeric characters and hyphens allowed
  bucket        = "${var.environment}-s3-config"
  acl           = "private"
  force_destroy = true # allow delete all objects so bucket can be destroyed
  versioning {
    enabled = true # we're not aiming to duplicate git
  }
  
server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }




}

# bucket is already private; this is "defence in depth"
resource "aws_s3_bucket_public_access_block" "s3_config" {
  bucket                  = aws_s3_bucket.s3_config.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "s3_config" {
  depends_on = [aws_s3_bucket_public_access_block.s3_config]
  bucket = aws_s3_bucket.s3_config.id
  policy = <<POLICY
{


    "Version": "2012-10-17",
    "Id": "RequireEncryption",
    "Statement": [
        {
            "Sid": "RequireEncryptedTransport",
            "Effect": "Deny",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.s3_config.bucket}/*"
            ],
            "Condition": {
                "Bool": {
                    "aws:SecureTransport": "false"
                }
            },
            "Principal": "*"
        }
    ]
}
POLICY
}
