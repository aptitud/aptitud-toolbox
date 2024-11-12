# list public and private function definition files
$publicScripts = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$privateScripts = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

# dot source the files
foreach ($script in @($publicScripts + $privateScripts)) {
    try {
        . $script.FullName
    }
    catch {
        Write-Error -Message "Failed to import function $($script.FullName): $_"
    }
}

# export any function named exactly as the file,
# from the public folder
Export-ModuleMember -Function $publicScripts.Basename -Alias *

