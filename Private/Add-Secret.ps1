function Add-Secret {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$SecretName,
    [Parameter(Mandatory = $false)]
    [string]$Labels
  )  
  
  gcloud secrets create $SecretName --project aptitud-secrets 2>$null

  if ($Labels) {
    Update-SecretLabels $SecretName --Labels=$Labels
  }
}

