<#
.SYNOPSIS

Get Secrets from Google Secret Manager

.DESCRIPTION

The cmdlet has 2 parameter sets.
Specify the SearchForName or SecretName parameter, but not both at the same time

SearchForName: string matches regex pattern, will present a menu with selections
SecretName: lookup known secret name

.EXAMPLE

PS> > Get-Secret -SearchForName abc

.EXAMPLE

PS> > Get-Secret -SearchForName "abc|xyz"    

.EXAMPLE

PS> > Get-Secret abc

Will default to SearchForName parameter

.EXAMPLE

PS> > Get-Secret -SearchForName abc -Clipboard

Will copy password to clipboard

.EXAMPLE

PS> > Get-Secret -SearchForName abc -SearchForLabel xyz

Will list every secret with name containing "abc" and label containing "xyz"

.EXAMPLE

PS> > Get-Secret -SearchForLabel xyz

Will list every secret with label containing "xyz"

.EXAMPLE

PS> > Get-Secret -SecretName secret_abc

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
  $rawResult = gcloud secrets versions access latest --secret=$Selection # For now the project specified in gcloud but later (--project aptitud-secrets)
  try {
    $Result = $rawResult | ConvertFrom-Json
  } catch {
    $Result = $rawResult
    Write-Host "Warning: Secret was not in JSON format and has been returned as raw text." -ForegroundColor Yellow
  }


  if ($Clipboard) {
    Write-host "Copying secret to clipboard" -ForegroundColor Green
    $Result | Set-Clipboard
  }

  $Result
}
