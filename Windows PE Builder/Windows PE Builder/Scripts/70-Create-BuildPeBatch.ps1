#
# Create_BuildPeBatch.ps1
#

Function global:Create-BuildPeBatch
{
    #
    # 1) パスを整える
    #
    # 選択したプラットフォームを確認
    $global:ProjectDirectoryPath = $MainWindow.FindName("ProjectPathTextBox").Text
    if ($MainWindow.FindName("SelectPlatformComboBox").SelectedItem -eq $MainWindow.FindName("Pe64ComboBoxItem"))
    {
        $PlatformId = "x64"
        $MsPlatformId = "amd64"
    }
    else
    {
        $PlatformId = "x86"
        $MsPlatformId = "x86"
    }
    
    $Path = Check-Path-ForWriteCommand($MainWindow.FindName("Option1PathTextBox").Text)
    $Option1 = $Path[0]
    $Option1Path = $Path[1]
    
    $Path = Check-Path-ForWriteCommand($MainWindow.FindName("Option2PathTextBox").Text)
    $Option2 = $Path[0]
    $Option2Path = $Path[1]
    
    $global:BuildedWindowsPePath = $MainWindow.FindName("SavePathTextBox").Text
    $global:BuildedWindowsPePath = $BuildedWindowsPePath.Replace("%PlatformId%",$PlatformId)

    # ADK関連のパス を選択肢の通りに直す
    $DeploymentToolsPath = Join-Path $WinAdkPath $DeploymentToolsPath
    $DandISetEnvPath = Join-Path $DeploymentToolsPath $DandISetEnvPath
    $WinPePath = Join-Path $WinAdkPath $WinPePath
    $WinPeOcsDirectoryPath = Join-Path $MsPlatformId $WinPeOcsDirectoryPath
    $WinPeOcsDirectoryPath = Join-Path $WinPePath $WinPeOcsDirectoryPath
    $EfisysNoPromptPath = Join-Path $MsPlatformId $EfisysNoPromptPath
    $EfisysNoPromptPath = Join-Path $DeploymentToolsPath $EfisysNoPromptPath
    $CopyPePath = Join-Path $WinPePath $CopyPePath
    $MakeWinPEMediaPath = Join-Path $WinPePath $MakeWinPEMediaPath

    $BaseBatchPath = Join-Path $BasedDirectory $BaseBatchPath
    $OptionPath = Join-Path $BasedDirectory $PlatformId
    # 作業フォルダーに展開するPEのパス
    $PeDirectory = Join-Path $global:ProjectDirectoryPath "bin\"
    
    # 読み込み
    $BaseBatch = Get-Content -Path $BaseBatchPath -Raw
    # 置換
    $BaseBatch = $BaseBatch.Replace("%ProjectDirectory%", $global:ProjectDirectoryPath)
    $BaseBatch = $BaseBatch.Replace("%PlatformId%", $PlatformId)
    $BaseBatch = $BaseBatch.Replace("%MsPlatformId%", $MsPlatformId)
    $BaseBatch = $BaseBatch.Replace("%DeploymentToolsPath%", $DeploymentToolsPath)
    $BaseBatch = $BaseBatch.Replace("%DandISetEnvPath%", $DandISetEnvPath)
    $BaseBatch = $BaseBatch.Replace("%WinPePath%", $WinPePath)
    $BaseBatch = $BaseBatch.Replace("%WinPeOcsDirectoryPath%", $WinPeOcsDirectoryPath)
    $BaseBatch = $BaseBatch.Replace("%EfisysNoPromptPath%", $EfisysNoPromptPath)
    $BaseBatch = $BaseBatch.Replace("%CopyPePath%", $CopyPePath)
    $BaseBatch = $BaseBatch.Replace("%MakeWinPEMediaPath%", $MakeWinPEMediaPath)
    $BaseBatch = $BaseBatch.Replace("%BaseBatchPath%", $BaseBatchPath)
    $BaseBatch = $BaseBatch.Replace("%OptionPath%", $OptionPath)
    $BaseBatch = $BaseBatch.Replace("%PeDirectory%", $PeDirectory)
    $BaseBatch = $BaseBatch.Replace("%BuildedWindowsPePath%", $BuildedWindowsPePath)
    $BaseBatch = $BaseBatch.Replace("%Support-Option1%", $Option1)
    $BaseBatch = $BaseBatch.Replace("%Option1Path%", $Option1Path)
    $BaseBatch = $BaseBatch.Replace("%Support-Option2%", $Option2)
    $BaseBatch = $BaseBatch.Replace("%Option2Path%", $Option2Path)

    #オプション
    $BaseBatch = $BaseBatch.Replace("%Support-WinPE-WMI%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportWmiCheckBox").IsChecked)))
    $BaseBatch = $BaseBatch.Replace("%Support-WinPE-Fonts-Legacy%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-FontSupport-JA-JP%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
    $BaseBatch = $BaseBatch.Replace("%Support-WinPE-FontSupport-KO-KR%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-FontSupport-ZH-CN%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-FontSupport-ZH-HK%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-FontSupport-ZH-TW%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-HTA%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportHtaCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-LegacySetup%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-MDAC%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-SecureStartup%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportSecureStartupCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-Setup%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportSetupCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-Setup-Client%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-Setup-Server%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-FontSupport-WinRE%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportWindowsReCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-Dot3Svc%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-EnhancedStorage%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-FMAPI%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-NetFx%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportNetFxCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-PowerShell%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportPsCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-PPPoE%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-RNDIS%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-Scripting%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportScriptingCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-DismCmdlets%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportDismCmdletsCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-SecureBootCmdlets%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportSecureBootCmdletsCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-StorageWMI%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportStorageWmiCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-WDS-Tools%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportWdsCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-WinPE-WinReCfg%", (Check-Boolean-ForWriteCommand($False)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-lp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-DismCmdlets_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-Dot3Svc_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-EnhancedStorage_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-HTA_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-LegacySetup_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-MDAC_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-NetFx_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-PowerShell_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-PPPoE_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-Rejuv_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-RNDIS_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-Scripting_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-SecureStartup_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-Setup_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-Setup-Client_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-Setup-Server_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-SRT_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-StorageWMI_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-WDS-Tools_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-WinReCfg_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese-WinPE-WMI_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	#$BaseBatch = $BaseBatch.Replace("%%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$BaseBatch = $BaseBatch.Replace("%Support-Japanese%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	
	#$BaseBatch = $BaseBatch.Replace("%%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("").IsChecked)))


    # 書き込み
    $global:BuildPeBatPath = Join-Path $global:ProjectDirectoryPath $BuildPeBatPath 
    Out-File -InputObject $BaseBatch -FilePath $global:BuildPeBatPath -Encoding default

}
