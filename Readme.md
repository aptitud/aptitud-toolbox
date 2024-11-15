# Aptitud Toolbox

## Requrements

## Requirements

-   Git
-   PowerShell Core

For some functionality you also need:

-   Google Cloud SDK
-   Google Cloud SDK PowerShell module (`Install-Module GoogleCloud`)

Login with your aptitud account  
`gcloud auth login`

## Installation

Run the following command in a PowerShell Core shell:

```powershell
& git clone git@github.com:aptitud/aptitud-toolbox.git "$($env:PSModulePath -split [System.IO.Path]::PathSeparator | Select-Object -First 1 | Join-Path -ChildPath 'AptitudToolbox')"
```

This puts AptitudToolbox to the path where PowerShell looks for modules. Restart the PowerShell Core session.

## Functions

To list all functions, you can use

```powershell
Get-ToolboxCommands
```

To get help about a function, you can type

```powershell
Get-Help <function>
# For example
Get-Help Set-Secret
```
