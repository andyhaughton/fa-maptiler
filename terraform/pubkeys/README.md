###################################################################################
#                                                                                 #
# Copyright 2015-2019 Forensic Analytics Limited. All rights reserved.            #
#                                                                                 #
# If you wish to use this software or any part of it for any purpose, you require #
#                                                                                 #
# an express licence given in writing by Forensic Analytics Limited.              #
#                                                                                 #
# Visit forensicanalytics.co.uk                                                   #
#                                                                                 #
###################################################################################



# pubkeys

Public keys **only** are stored here. Private keys are not stored in Git for
obvious reasons.

Keys in this folder should named in the format `<environment>.pub` e.g.
`fa-maptiler.pub`. This automatically allows different keys for different
environments. See `../main.tf` and `.tfvars` files for how this variable is
created and used.

## Private keys

Private keys are stored in Chamber. They're gzipped and base64 encoded. This
isn't strictly necessary for private keys but is a standard pattern for longer
strings that might otherwise be too long for AWS Parameter Store, it also
defends against possible issues with line breaks.

### To write

    cat <privatekeyfile> | gzip | base64 | AWS_PROFILE=fa-maptiler chamber write secrets <keyname> -

For example:

    cat ~/.ssh/fa-maptiler | gzip | base64 | AWS_PROFILE=fa-maptiler chamber write secrets fa-maptiler -

The `-` flag tells chamber to read from stdin.

### To read

    AWS_PROFILE=fa-maptiler chamber read -q secrets <keyname> | base64 -D | gzip -d

For example:

    AWS_PROFILE=fa-maptiler chamber read -q secrets fa-maptiler | base64 -D | gzip -d

The `-q` flag tells chamber to only output the secret, not associated metadata.
The base64 and gzip flags are case-sensitive.
