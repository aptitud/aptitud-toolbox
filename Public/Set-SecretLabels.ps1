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
