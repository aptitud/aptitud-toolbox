<#
.SYNOPSIS
    Get an Aptitud secret
.DESCRIPTION
    This function will try to get a secret from Google Secret Manger 
    If more than one secrets are found a selection menu will be shown
.PARAMETER SearchForName
    Regex pattern search of secret names
.PARAMETER SearchForLabel
    Regex pattern search of labels
.PARAMETER SecretName
    Lookup known secret name
.PARAMETER Clipboard
    Switch used to get the result direct into your clipboard
.EXAMPLE
    PS> > Get-Secret -SearchForName "MySec"
.EXAMPLE
    PS> > Get-Secret -SearchForLabel "application"
.EXAMPLE
    PS> > Get-Secret -Secretname "MySecret"
.EXAMPLE
    PS> > Get-Secret MySec
    Will default to SearchForName parameter
.EXAMPLE
    PS> > Get-Secret -SecretName "MySecret" -Clipboard
    Will copy secret value to clipboard
#>
function Get-Secret {
  [CmdletBinding()]
  param (
    [string[]]
    $SearchForName,
    [string[]]
    $SearchForLabel,
    [string[]]
    $SecretName,
    [switch]
    $Clipboard
  )

  if ($SearchForName -or $SearchForLabel) {
    $ListResults = Show-Secrets -SearchForName $SearchForName -SearchForLabel $SearchForLabel
    if ($ListResults.Count -eq 1) {
      $Selection = $ListResults.Name
    }
    elseif ($ListResults.Count -eq 0) {
      throw "Secret not found"
    }
    else {
      $Selection = Show-Menu -Objects $ListResults
    }
  }
  else {
    $Selection = $SecretName
  }
  $Selection
  $rawResult = gcloud secrets versions access latest --secret=$Selection --project aptitud-secrets
  try {
    $Result = $rawResult | ConvertFrom-Json
  }
  catch {
    $Result = $rawResult
    # Write-Host "Warning: Secret was not in JSON format and has been returned as raw text." -ForegroundColor Yellow
  }

  if ($Clipboard) {
    Write-host "Copying secret to clipboard" -ForegroundColor Green
    $Result | Set-Clipboard
  }

  $Result
}
