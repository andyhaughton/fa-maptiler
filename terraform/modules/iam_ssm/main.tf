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
resource "aws_iam_group" "fa-maptiler-ssm" {
  name = "fa-maptiler-ssm"
  
}

resource "aws_iam_group_policy_attachment" "fa-maptiler-ssm-attach" {
  group      = "fa-maptiler-ssm"
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  depends_on = [aws_iam_group.fa-maptiler-ssm]
}

resource "aws_iam_user" "fa-maptiler-ssm_param_rw" {
  name = "fa-maptiler-ssm_param_rw"
}



# need an access key to pass to Ansible
resource "aws_iam_access_key" "fa-maptiler-ssm" {
  user = aws_iam_user.fa-maptiler-ssm_param_rw.name
}

resource "aws_iam_group_membership" "fa-maptiler-ssm-members" {
  name  = "fa-maptiler-ssm-members" 
  group = "fa-maptiler-ssm"
  users = [
    "${aws_iam_user.fa-maptiler-ssm_param_rw.name}" 
  ]
}
