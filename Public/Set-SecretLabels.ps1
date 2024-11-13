<#
.SYNOPSIS
    Add labels on an Aptitud secret
.DESCRIPTION
    This function will add labels to an existing secret
.PARAMETER SecretName
    The name of the secret
.PARAMETER Labels
    A key value pair list of labels to add to the secret
    Only hyphens (-), underscores (_), lowercase characters, and numbers are allowed
.EXAMPLE
    PS> > Set-SecretLabels -SecretName "MySecret" -Labels "type=application"
.EXAMPLE
    PS> > Set-SecretLabels -SecretName "MySecret" -Labels "type=application,format=json"
#>

function Set-SecretLabels {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$SecretName,
    [Parameter(Mandatory = $true)]
    [string]$Labels
  )  
  
  Update-SecretLabels -SecretName $SecretName -Labels $Labels
}
