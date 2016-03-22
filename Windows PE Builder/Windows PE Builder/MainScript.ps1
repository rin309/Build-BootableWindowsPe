#
# Windows PE Builder
#

$script:ApplicationTitle = "Windows PE環境の構築"
$script:LastUpdated = "2016/3/21"
$script:Author = "morokoshidog"

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# このスクリプトがあるフォルダー
$script:BasedDirectory = Split-Path $MyInvocation.MyCommand.Path -Parent

# プロジェクトフォルダーの初期値
$script:ProjectDirectoryPath = ""

# オプション2のファイルがあるフォルダー
$global:Option2Path = "%BasedDirectory%\Assets\%PlatformId%"

# スクリプトの読み込み
Get-ChildItem (join-path $BasedDirectory "Scripts") -Include "*.ps1" -Recurse | ForEach {& $_.FullName}

$script:MainWindow = Load-Xaml
if ($MainWindow.ShowDialog() -eq $true)
{
    cls
    write-host コマンドプロンプトの画面が自動で閉じるまでしばらくお待ちください...
    Create-BuildPeBatch
	start-process "cmd" -argumentlist ("/c","""",$BuildPeBatPath,"""") -verb runas -wait
	#start-process "explorer" -argumentlist ("/n,/select,""{0}""" -f $BuildPeBatPath)
	start-process "explorer" -argumentlist ("/n,/select,""{0}""" -f $BuildedWindowsPePath)
}


