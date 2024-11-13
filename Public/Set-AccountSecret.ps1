<#
.SYNOPSIS
    Add or update an Aptitud account secret
.DESCRIPTION
    Adds a secret in a json format. Where Username, Password, Url and Notes as specified
.PARAMETER SecretName
    The name of the secret to add or update
    Secret names can only contain English letters (A-Z,a-z), numbers (0-9), dashes (-), and underscores (_)
.PARAMETER Username
    Username for the account
.PARAMETER Password
    Password for the account
.PARAMETER Url
    Url for the account
.PARAMETER Notes
    Notes for the account
.EXAMPLE
    Set-AccountSecret -SecretName "MySecret" -Username "username" -Password "password"
.EXAMPLE
    Set-AccountSecret -SecretName "MySecret" -Username "username" -Password "password" -Url "www.test.com"
.EXAMPLE
    Set-AccountSecret -SecretName "MySecret" -Username "username" -Password "password" -Url "www.test.com" -Notes "Some notes for the account"
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
  
  Add-Secret -SecretName $SecretName -Labels "type=account,format=json"

  Write-Output @"
{
  "Url": "$Url",
  "Username": "$Username",
  "Password": "$Password",
  "Notes": "$Notes"
}
"@ | gcloud secrets versions add $SecretName --project aptitud-secrets --data-file=-
}

