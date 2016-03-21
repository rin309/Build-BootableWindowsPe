#
# Extis_Path.ps1
#

Function global:Extis-Path($Path)
{
    if ($Path -eq $null)
    {
        return ""
    }
    if (Test-Path $Path)
    {
        return $Path
    }
    else
    {
        return
    }
}