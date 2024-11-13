
function Set-Secret {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)]
    [string]$SecretName,
    [Parameter(Mandatory = $false)]
    [string]$Secret,
    [Parameter(Mandatory = $false)]
    [string]$File
  )  
  
  if (!$Secret && !$File) {
    Write-Error -Message "One of the parameters -Secret or -File must be set."
    break
  }

  if ($Secret && $File) {
    Write-Error -Message "Only one of the parameters -Secret or -File can be set."
    break
  }

  Add-Secret -SecretName $SecretName

  if ($Secret) {
    Write-Output $Secret | gcloud secrets versions add $SecretName --project aptitud-secrets --data-file=-
  }
  if ($File) {
    gcloud secrets versions add $SecretName --project aptitud-secrets --data-file=$File
  }
}

