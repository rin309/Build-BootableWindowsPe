#
# Write_Command.ps1
#

Function global:Write-Command($Line)
{
    $BuildPePath = Join-Path $ProjectDirectoryPath $BuildPePath 
    Out-File -InputObject $Line -FilePath $BuildPePath -Append
}

Function global:Check-Path-ForWriteCoomand($Path)
{
    if ($Path -ne "")
    {
        $Path = $Path.Replace("%PlatformId%",$PlatformId)
		$Path = $Path.Replace("%BasedDirectory%", $BasedDirectory)
        return "", $Path
    }
    else
    {
        return "@rem ", ""
    }
}

Function global:Check-Boolean-ForWriteCoomand($Checked)
{
    if ($Checked -eq $true)
    {
        return ""
    }
    else
    {
        return "@rem "
    }
}