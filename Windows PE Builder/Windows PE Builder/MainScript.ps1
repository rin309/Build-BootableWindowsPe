#
# Windows PE Builder
#

$script:ApplicationTitle = "Windows PE環境の構築"
$script:LastUpdated = "2016/4/14"
$script:Author = "morokoshidog"

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# このスクリプトがあるフォルダー
$script:BasedDirectory = Split-Path $MyInvocation.MyCommand.Path -Parent

# プロジェクトフォルダーの初期値
$script:ProjectDirectoryPath = ""

# オプション2のファイルがあるフォルダー
$Global:Option2Path = "%BasedDirectory%\Assets\%PlatformId%"

# スクリプトの読み込み
Get-ChildItem (join-path $BasedDirectory "Scripts") -Include "*.ps1" -Recurse | ForEach {& $_.FullName}

$script:MainWindow = Load-Xaml

if ($MainWindow.ShowDialog() -eq $False)
{
	write-host "キャンセルされました"
}
else
{
	Begin-CreateBuildPeBatch
}



