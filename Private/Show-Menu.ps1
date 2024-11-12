function Show-Menu {

    param (
        [string]$Title = 'Secrets',
        $Objects
    )
    #Clear-Host
    Write-Host "================ $Title ================"
    $Tostring = $Objects | Format-Table | Out-String
    $Menu = @{}
    $Tostring -split "`n" | ForEach-Object  -Begin { $i = 1 } {
        $name = ($_ -split " ")[0]
        write-host " [$i] $_"
        $Menu.add("$i", $name)
        $i++
    }
    Write-Host "Q: Press 'Q' to quit."
    $Selection = Read-Host "Please make a selection"
    if ($Selection -eq 'Q') { 
        break 
    }
    Else { 
        $Menu.$Selection 
    }

}
