<#
.SYNOPSIS

Update the PowerShell module AptitudToolbox with the latest version

.EXAMPLE

PS> > Update-AptitudToolbox

#>
function Update-AptitudToolbox {

    [CmdletBinding()]
    param (
    )

    begin {
        $ErrorActionPreference = 'Stop'

        [string] $moduleRoot = Join-Path $PSScriptRoot '..'
    }

    process {
        Push-Location $moduleRoot

        try {
            & git checkout main

            if ($LASTEXITCODE -ne 0) {
                throw "Failed to git checkout the main branch"
            }

            & git pull origin main

            if ($LASTEXITCODE -ne 0) {
                throw "Failed to git pull the latest main version"
            }


        }
        finally {
            Pop-Location
        }

        Write-Host ""
        Write-Host "Done updating. You must close this PowerShell session to use the new version."
    }
}
