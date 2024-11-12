<#
.SYNOPSIS

Update an account secret in Google Secret Manager

.DESCRIPTION

Update a secret with the given name and creates a secret version with the given data.

.EXAMPLE

PS> > Set-AccountSecret  -Url www.abc.com -SecretName abc -Username user123 -Password pwd123 -Notes "this is a note" 

Creates a new version of the account secret with all the parameters

.EXAMPLE

PS> > Set-AccountSecret -SecretName sqluser2 -Username sqluser1  -Password sql123

Creates a secret with all the mandatory parameters

.EXAMPLE

PS> > Set-CloudSecret

Creates a secret with all the mandatory parameters

#>

function Set-AccountSecret {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$SecretName,
    [Parameter(Mandatory = $true)]
    [string]$Username,
    [Parameter(Mandatory = $true)]
    [string]$Password,
    [Parameter(Mandatory = $false)]
    [string]$Url,
    [Parameter(Mandatory = $false)]
    [string]$Notes
  )  
  
    Create-Secret -SecretName $SecretName

  Write-Output @"
{
  "Username": "$Username",
  "Notes": "$Notes",
  "Url": "$Url",
  "Password": "$Password"
}
"@ | gcloud secrets versions add $SecretName --project aptitud-secrets --data-file=-
}

