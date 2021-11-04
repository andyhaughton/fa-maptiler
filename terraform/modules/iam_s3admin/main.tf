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
resource "aws_iam_group" "fa-maptiler-s3-admin" {
  name = "fa-maptiler-s3-admin"
  
}

resource "aws_iam_group_policy_attachment" "fa-maptiler-s3-admin-attach" {
  group      = "fa-maptiler-s3-admin"
  depends_on = [aws_iam_group.fa-maptiler-s3-admin]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}



resource "aws_iam_user" "fa-maptiler-fa-maptiler-s3-admin" {
  name = "fa-maptiler-fa-maptiler-s3-admin"
}



# need an access key to pass to Ansible
resource "aws_iam_access_key" "fa-maptiler-s3-admin" {
  user = aws_iam_user.fa-maptiler-fa-maptiler-s3-admin.name
}

resource "aws_iam_group_membership" "fa-maptiler-s3-admin-members" {
  name  = "fa-maptiler-s3-admin-members" 
  group = "fa-maptiler-s3-admin"
  users = [
    "${aws_iam_user.fa-maptiler-fa-maptiler-s3-admin.name}" 
  ]
}
