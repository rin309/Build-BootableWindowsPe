#
# Write_Command.ps1
#

Function global:Write-Command($Line)
{
    $CommandPath = Join-Path $Global:ProjectDirectoryPath $BuildPePath 
    Out-File -InputObject $Line -FilePath $CommandPath -Append
}

Function global:Check-Path-ForWriteCommand($Path)
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

Function global:Check-Boolean-ForWriteCommand($Checked)
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