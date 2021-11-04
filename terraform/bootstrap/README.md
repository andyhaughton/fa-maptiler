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

# Bootstrap remote state

This folder is used to bootstrap Terraform's remote state and secrets management.

## Usage

    export AWS_PROFILE=fa-maptiler
    terraform init && terraform apply

You only need to do this once.

## To do

If we dynamically create the bucket name based upon the current git branch (see
`../scripts/get_git_branch.py`) then we could maybe do away with workspaces -
just create a new bucket for each git branch (though over time this may lead to
a proliferation of buckets). Something to think about.
