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
resource "aws_instance" "fa-maptiler-ec2_linux_server" {
  ami                         = var.ami_id
  key_name                    = var.key_name
  instance_type               = var.instance_type
  subnet_id                   = element(var.subnet_ids, 0)
  associate_public_ip_address = var.public_ip
  get_password_data           = false
 
  
  vpc_security_group_ids = [
    aws_security_group.ec2_linux_sg.id
  ]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "200"
    delete_on_termination = true
    encrypted             = true
  }

 

  tags = {
    Environment = var.environment
    Name = "${var.environment}_ec2_linux"
  }

  lifecycle {
    ignore_changes = [ebs_block_device]
    
  }

}
