#
# Extis_Path.ps1
#

Function Global:Extis-Path($Path)
{
    If ($Path -eq $null)
    {
        Return ""
    }
    If (Test-Path $Path)
    {
        Return $Path
    }
    Else
    {
        return
    }
}