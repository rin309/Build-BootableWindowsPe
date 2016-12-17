#
# Write_Command.ps1
#

Function Global:Write-Command($Line)
{
    $CommandPath = Join-Path $Script:ProjectDirectoryPath $BuildPePath 
    Out-File -InputObject $Line -FilePath $CommandPath -Append
}

Function Global:Check-Path-ForWriteCommand($Path)
{
    If ($Path -ne "")
    {
        $Path = $Path.Replace("%PlatformId%",$PlatformId)
		$Path = $Path.Replace("%BasedDirectory%", $BasedDirectory)
        Return "", $Path
    }
    Else
    {
        Return "@rem ", ""
    }
}

Function Global:Check-Boolean-ForWriteCommand($Checked)
{
    If ($Checked -eq $True)
    {
        Return ""
    }
    Else
    {
        Return "@rem "
    }
}