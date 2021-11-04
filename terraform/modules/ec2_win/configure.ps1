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
<powershell>
#This file is passed as userdata script in the Terraform apply

$Global:LogFile               = "C:\Windows\Debug\FA_Automation.Log"
$Global:ServerName            = "FA-MAPTILER-WIN"
$Global:LocalAdminPassword    = "${local_admin_password}"
$Global:S3AccessKey           = "${s3admin_accesskey.id}"
$Global:S3SecretKey           = "${s3admin_accesskey.secret}"
$Global:Environment           = "${environment}"
$Global:Region                = "eu-west-2"
$Global:MSILogFile            = "C:\Windows\Debug\FA_CSAS.Log"
 


Function Set-AdminPassword{
  Param()

  Begin{
          Add-Content $LogFile 'Set-AdminPassword'
  }

   Process{
    Try{
          $UserAccount = Get-LocalUser -Name 'Administrator'
          $UserAccount | Set-LocalUser -Password (ConvertTo-SecureString -AsPlainText $LocalAdminPassword -Force)
          New-Item -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Password
        }

    Catch{
            Add-Content $LogFile $error
            Break
    }
  }

  End{
    If($?){
    }
  }
}

Function Rename-Server{
  Param()

  Begin{
          Add-Content $LogFile 'Rename-Server'
  }

  Process{
    Try{

          Rename-Computer -NewName $ServerName
          New-Item -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Rename -Force
          Restart-Computer -Force
        }

    Catch{
            Add-Content $LogFile $error
            Break
    }
  }

  End{
    If($?){
    }
  }
}

Function Download-S3-Bucket{
  Param()

  Begin{
          Add-Content $LogFile 'Download-S3-Bucket1'
  }

  Process{
    Try{

          Import-Module AWSPowershell
          $BucketName = "$Environment-s3-config"
          $localPath  = "C:\Scripts"
          $objects    = Get-S3Object -BucketName $bucketname -AccessKey $S3AccessKey -SecretKey $S3SecretKey -Region $region
          
          
          foreach($object in $objects)
          {
              $localfilename = $object.key
              $localFilePath = Join-Path $localPath $localFileName 
              Copy-S3Object -BucketName $bucketname -Key $object.Key -LocalFile $localfilepath -AccessKey $S3AccessKey -SecretKey $S3SecretKey -Region $region
          }
          
          New-Item -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Bucket -Force
        }

    Catch{
          Add-Content $LogFile $error
      Break
    }
  }

  End{
    If($?){
    }
  }
}

Function Unzip-Files{
  Param()

  Begin{
          Add-Content $LogFile 'Unzip-Files'
  }

  Process{
    Try{
          Expand-Archive -path 'C:\Scripts\config\CSAS.zip' -destinationpath 'C:\Scripts\config'
          Expand-Archive -path 'C:\Scripts\config\CSASWorking.zip' -destinationpath 'C:\CSAS'
          Expand-Archive -path 'C:\Scripts\config\Maptiler.zip' -destinationpath 'C:\Maptiler'
          New-Item -Path C:\ProgramData\FA\Automation\\Unzip -Force
        }

    Catch{
          Add-Content $LogFile $error
      Break
    }
  }

  End{
    If($?){
    }
  }
}

Function Install-CSAS{
  Param()

  Begin{
          Add-Content $LogFile 'Install-CSAS'
  }

  Process{
    Try{
          $MSI = Get-ChildItem 'C:\Scripts\config\CSAS'  | where {$_.name -match '.msi'}
          $MSI = $MSI.FullName
          Start-Process -FilePath "msiexec.exe" -wait -ArgumentList "/i ""$MSI"" /quiet /L*V! $MSILogFile"
          New-Item -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\CSAS -Force
        }

    Catch{
          Add-Content $LogFile $error
      Break
    }
  }

  End{
    If($?){
    }
  }
}

Function Install-Putty{
  Param()

  Begin{
          Add-Content $LogFile 'Install-Putty'
  }

  Process{
    Try{
          $MSI = Get-ChildItem 'C:\Scripts\config\Putty'  | where {$_.name -match '.msi'}
          $MSI = $MSI.FullName
          Start-Process -FilePath "msiexec.exe" -wait -ArgumentList "/i ""$MSI"" /quiet"
          New-Item -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Putty -Force
        }

    Catch{
          Add-Content $LogFile $error
      Break
    }
  }

  End{
    If($?){
    }
  }
}

Function Create-Task{
  Param()

  Begin{
          Add-Content $LogFile 'Create-Task'
  }

  Process{
    Try{
          $cmd = "schtasks.exe /Create /XML 'C:\Maptiler\Scripts\Stop-IdleProcess.xml' /tn 'Stop-IdleProcess' /ru administrator /rp $LocalAdminPassword"
          Invoke-Expression $cmd
          New-Item -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Task -Force
        }

    Catch{
          Add-Content $LogFile $error
      Break
    }
  }

  End{
    If($?){
    }
  }
}

#-----------------------------------------------------------[Execution]------------------------------------------------------------

#Reset Local Administrator Password
If ((Test-path -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Password) -eq $false)
{
  Set-AdminPassword
}

#Rename Server
If ((Test-path -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Rename) -eq $false)
{
  Rename-Server
}

#Download S3 Bucket
If ((Test-path -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Bucket) -eq $false)
{
  Download-S3-Bucket
}

#Unzip Files
If ((Test-path -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Unzip) -eq $false)
{
  Unzip-Files
}

#Install CSAS
If ((Test-path -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\CSAS) -eq $false)
{
  Install-CSAS
}

#Install Putty
If ((Test-path -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Putty) -eq $false)
{
  Install-Putty
}

#Create Task
If ((Test-path -Path C:\ProgramData\FA\Automation\ec2_maptiler_win\Task) -eq $false)
{
  Create-Task
}






</powershell>
<persist>true</persist>
