#
# Initialize.ps1
#

# スクリプトがあるフォルダー
$script:ProjectDirectoryPath = ""
$global:BuildedWindowsPePath = "WindowsPE-%PlatformId%.iso"
$global:BaseBatchPath = "assets\base.txt"

# Build-Peコマンドのパス
$global:BuildPePath = "Build-Pe.bat"

# ADK関連のパス
$global:DeploymentToolsPath = "Assessment and Deployment Kit\Deployment Tools\"
$global:DandISetEnvPath = "DandISetEnv.bat"
$global:WinPePath = "Assessment and Deployment Kit\Windows Preinstallation Environment\"
$global:WinPeOcsDirectoryPath = "WinPE_OCs\"
$global:EfisysNoPromptPath = "Oscdimg\efisys_noprompt.bin"
$global:CopyPePath = "copype.cmd"
$global:MakeWinPEMediaPath = "MakeWinPEMedia.cmd"



# 使用中のプラットフォームによる差異を確認
if ([Environment]::Is64BitProcess -eq $true)
{
    if ((Test-Path -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots") -eq $true)
    {
        $global:WinAdkPath = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots").KitsRoot10
        if ($global:WinAdkPath -eq $null)
        {
            $global:WinAdkPath = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots").KitsRoot81
        }
    }
    # Ghost関連のパス
    if ((Test-Path -Path HKLM:SOFTWARE\Wow6432Node\Symantec\Ghost) -eq $true)
    {
        $global:GhostPath = $(Get-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Symantec\Ghost).InstallDir
        $global:GhostPath = Join-Path $global:GhostPath "bootwiz\OEM\GSS\winpe\%PlatformId%\Base\mount"
    }
}
else
{
    if ((Test-Path -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots") -eq $true)
    {
        $global:WinAdkPath = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots").KitsRoot10
        if ($global:WinAdkPath -eq $null)
        {
            $global:WinAdkPath = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots").KitsRoot81
        }
    }
    # Ghost関連のパス
    if ((Test-Path -Path HKLM:SOFTWARE\Symantec\Ghost) -eq $true)
    {
        $global:GhostPath = $(Get-ItemProperty -Path HKLM:SOFTWARE\Symantec\Ghost).InstallDir
        $global:GhostPath = Join-Path $global:GhostPath "bootwiz\OEM\GSS\winpe\%PlatformId%\Base\mount"
    }
}
