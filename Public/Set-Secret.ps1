<#
.SYNOPSIS
    Add or update an Aptitud secret
.DESCRIPTION
    This function will add or update a secret in Google Secret Manger
.PARAMETER SecretName
    The name of the secret to add or update (Mandatory)
    Secret names can only contain English letters (A-Z,a-z), numbers (0-9), dashes (-), and underscores (_)
.PARAMETER Value
    The secret value that will be assigned to the secret (Mandatory if parameter File is missing)
.PARAMETER File
    path to a file whose contents will be assigned to the secret (Mandatory if parameter Value is missing)
.EXAMPLE
    Set-Secret -SecretName "MySecret" -Value "My Secret Value"
.EXAMPLE
    Set-Secret -SecretName "MySecret" -File "c:\dev\my-secret-file.txt"
    #>

function Set-Secret {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$SecretName,
    [Parameter(Mandatory = $false)]
    [string]$Value,
    [Parameter(Mandatory = $false)]
    [string]$File
  )  
  
  [bool]$ValueIsSpecified = $Value.Trim().Length -gt 0
  [bool]$FileIsSpecified = $File.Trim().Length -gt 0

  if ($ValueIsSpecified -and $FileIsSpecified) {
    Write-Error -Message "One of the parameters -Value or -File must be set."
    break
  }

  if (!$ValueIsSpecified -and !$FileIsSpecified) {
    Write-Error -Message "Only one of the parameters -Value or -File can be set."
    break
  }

  Add-Secret -SecretName $SecretName

  if ($ValueIsSpecified) {
    Write-Output $Value | gcloud secrets versions add $SecretName --project aptitud-secrets --data-file=-
  }
  if ($FileIsSpecified) {
    gcloud secrets versions add $SecretName --project aptitud-secrets --data-file=$File
  }
}

