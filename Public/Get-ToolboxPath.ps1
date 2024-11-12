<#
.SYNOPSIS

Get the Toolbox folder path (to open in for example VS Code)

.DESCRIPTION

Get the path to the Toolbox folder

.EXAMPLE

PS> > Get-ToolboxPath

.EXAMPLE

PS> > explorer "$(Get-ToolboxPath)"

.EXAMPLE

PS> > code "$(Get-ToolboxPath)"

#>
function Get-ToolboxPath {
    return Split-Path $PSScriptRoot
}
