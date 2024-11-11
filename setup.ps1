if(Get-Module -Name Functions -ListAvailable)
{
    Import-Module Functions
} else {
    $FirstModulePath = $env:PSModulePath -split ';' | Select-Object -First 1
    Write-Output "Installing 'Function' module to $FirstModulePath".
    New-Item -ItemType Junction -Path "$FirstModulePath\Functions" -Target $PSScriptRoot\Functions\ | Out-Null
    Import-Module Functions
}

Install-Scoop
Install-ScoopApps $PSScriptRoot/scoop.json
Install-GoogleCloudSDK
