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
resource "aws_instance" "fa-maptiler-ec2_win" {
  ami                         = var.ami_id
  key_name                    = var.key_name
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet_ids, 0)
  associate_public_ip_address = var.public_ip
  get_password_data           = false
  user_data = templatefile("${path.module}/configure.ps1", {
     environment             = var.environment
     s3admin_accesskey       = var.s3_admin_accesskey
     local_admin_password    = data.aws_ssm_parameter.ec2_win_maptiler_local_admin_password.value
     ssm_param_rw_accesskey  = var.ssm_param_rw_accesskey
     s3admin_accesskey       = var.s3_admin_accesskey

   })
  
  vpc_security_group_ids = [
    aws_security_group.ec2_maptiler_win_sg.id
  ]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "60"
    delete_on_termination = true
    encrypted             = true
  }

  # volume for D:
  ebs_block_device {
    device_name           = "xvdf"
    volume_size           = 500
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Environment = var.environment
    Name = "${var.environment}_ec2_maptiler_win"
  }

  lifecycle {
    ignore_changes = [ebs_block_device]
    
  }

}
