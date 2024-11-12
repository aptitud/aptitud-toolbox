<#
.SYNOPSIS

Get the Toolbox commands available

.DESCRIPTION

Get the public Toolbox commands available,
so that you know what commands are named (in case you forgot).

.EXAMPLE

PS> > Get-ToolboxCommands

#>
function Get-ToolboxCommands {
    (Get-Command -Module AptitudToolbox).Name
}
