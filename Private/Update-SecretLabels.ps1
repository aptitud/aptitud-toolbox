function Update-SecretLabels {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$SecretName,
    [Parameter(Mandatory = $true)]
    [string]$Labels
  )  
  
  gcloud secrets update $SecretName --update-labels=$Labels --project aptitud-secrets
}

