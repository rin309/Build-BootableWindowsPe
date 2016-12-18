#
# Windows PE Builder
#

$Script:ApplicationTitle = "Windows PE Builder"
$Script:LastUpdated = "20161217"
$Script:Author = "morokoshidog"

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

### オプション設定 ###
#
# このスクリプトがあるフォルダー
$Script:BasedDirectory = Split-Path $MyInvocation.MyCommand.Path -Parent
#
# プロジェクトフォルダーの初期値
$Global:ProjectDirectoryPath = "D:\Windows PE"
#
# ドライバーがあるフォルダー
$Global:DriverDirectoryPath = "%ProjectDirectory%\Drivers\%PlatformId%"
#
# オプション2のファイルがあるフォルダー
$Global:Option2Path = "%ProjectDirectory%\Base\%PlatformId%"
#
# ライセンス許諾状況
$Script:LicenseAgreement = $False
#
######################


# スクリプトの読み込み
Get-ChildItem (Join-Path $BasedDirectory "Scripts") -Include "*.ps1" -Recurse | ForEach {& $_.FullName}
$Script:MainWindow = Load-Xaml
If ($MainWindow.ShowDialog() -eq $False)
{
	Write-Host "キャンセルされました"
}
Else
{
	Begin-CreateBuildPeBatch
}
