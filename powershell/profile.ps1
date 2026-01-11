function prompt() {
  $currentDir = $PWD.Path.Replace($HOME, "~")

  Write-Host "PS " -NoNewLine
  Write-Host "$currentDir" -ForegroundColor "Blue"
  Write-Host ">" -NoNewLine

  return " "
}

Set-Alias -Name ll -Value Get-ChildItem
