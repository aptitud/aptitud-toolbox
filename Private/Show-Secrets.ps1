function Show-Secrets {
  [CmdletBinding()]
  param (
    $SearchForName,
    $SearchForLabel
  )

  $list = gcloud secrets list --format="json" | ConvertFrom-Json # TODO use predefined project (--project aptitud-secrets)

  $Results = @()
  $Obj = @()

  foreach ($item in $list) {
    $LabelName = ""
    if ($null -ne $item.labels) {
      $LabelName = $item.Labels | Get-Member | Where-Object { $_.MemberType -match 'NoteProperty' }
    }
    $Obj = New-Object -TypeName PSObject
    $Obj | Add-Member -MemberType NoteProperty -Name Name -Value $item.Name.Split("/")[-1]
    $Obj | Add-Member -MemberType NoteProperty -Name Labels -Value ($LabelName.Definition | Out-String -NoNewline).Replace("string","")
    $Results += $Obj
  }
  $Results = $Results |  Where-Object {$_.name -match $SearchForName}
  $Results | Where-Object {$_.labels -match $SearchForLabel}
}
