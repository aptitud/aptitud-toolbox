#
# Module manifest for module 'AptitudToolbox'
#

@{
    ModuleVersion     = '0.1.0'
    GUID              = 'c8cde016-1a9e-44e1-bb29-49de14b2a608'
    Author            = 'Aptitud <info@aptitud.se>'
    CompanyName       = 'Aptitud'
    Copyright         = ''
    Description       = ''

    RootModule        = 'AptitudToolbox.psm1'

    # The list of functions to export should mirror the list of
    # files in the 'Public' folder.
    # We *could* put a wildcard here to simplify things - but then
    # PowerShell will not be able to autoload the module when typing
    # the function names.
    FunctionsToExport = @(
        'Get-ToolboxCommands',
        'Get-ToolboxPath',
        'Get-Secret',
        'Set-Secret',
        'Set-AccountSecret',
        'Set-SecretLabels',
        "Update-AptitudToolbox"
    )

    CmdletsToExport   = @()
    AliasesToExport   = @()
    VariablesToExport = @()
}
