#
# Create_BuildPeBatch.ps1
#

Function global:Replace-BuilderEnvironment($Base)
{
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

	$global:WinAdkPath = $MainWindow.FindName("WindowsAdkPathTextBox").Text

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
    $PeDirectory = Join-Path $ProjectDirectoryPath $PlatformId
    
    # 置換
    $Base = $Base.Replace("%ProjectDirectory%", $global:ProjectDirectoryPath)
    $Base = $Base.Replace("%PlatformId%", $PlatformId)
    $Base = $Base.Replace("%MsPlatformId%", $MsPlatformId)
    $Base = $Base.Replace("%DeploymentToolsPath%", $DeploymentToolsPath)
    $Base = $Base.Replace("%DandISetEnvPath%", $DandISetEnvPath)
    $Base = $Base.Replace("%WinPePath%", $WinPePath)
    $Base = $Base.Replace("%WinPeOcsDirectoryPath%", $WinPeOcsDirectoryPath)
    $Base = $Base.Replace("%EfisysNoPromptPath%", $EfisysNoPromptPath)
    $Base = $Base.Replace("%CopyPePath%", $CopyPePath)
    $Base = $Base.Replace("%MakeWinPEMediaPath%", $MakeWinPEMediaPath)
    $Base = $Base.Replace("%BaseBatchPath%", $BaseBatchPath)
    $Base = $Base.Replace("%OptionPath%", $OptionPath)
    $Base = $Base.Replace("%PeDirectory%", $PeDirectory)
    $Base = $Base.Replace("%BuildedWindowsPePath%", $BuildedWindowsPePath)
    $Base = $Base.Replace("%Support-Option1%", $Option1)
    $Base = $Base.Replace("%Support-Option1%", $Option1)
    $Base = $Base.Replace("%Option1Path%", $Option1Path)
    $Base = $Base.Replace("%Support-Option2%", $Option2)
    $Base = $Base.Replace("%Option2Path%", $Option2Path)
	
	$Base = $Base.Replace("%WindowsInstallWimPath%", $WindowsInstallWimPath)
    $Base = $Base.Replace("%Support-CopyWimFile%", (Check-Boolean-ForWriteCommand($CopyWimFilePath.Length -eq 0)))
    $Base = $Base.Replace("%CopyWimFilePath%", $CopyWimFilePath)
	

    #オプション
    $Base = $Base.Replace("%Support-WinPE-WMI%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportWmiCheckBox").IsChecked)))
    $Base = $Base.Replace("%Support-WinPE-Fonts-Legacy%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-FontSupport-JA-JP%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
    $Base = $Base.Replace("%Support-WinPE-FontSupport-KO-KR%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-FontSupport-ZH-CN%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-FontSupport-ZH-HK%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-FontSupport-ZH-TW%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-HTA%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportHtaCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-LegacySetup%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-MDAC%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-SecureStartup%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportSecureStartupCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-Setup%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportSetupCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-Setup-Client%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-Setup-Server%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-FontSupport-WinRE%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportWindowsReCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-Dot3Svc%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-EnhancedStorage%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-FMAPI%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-NetFx%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportNetFxCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-PowerShell%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportPsCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-PPPoE%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-RNDIS%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-WinPE-Scripting%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportScriptingCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-DismCmdlets%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportDismCmdletsCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-SecureBootCmdlets%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportSecureBootCmdletsCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-StorageWMI%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportStorageWmiCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-WDS-Tools%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportWdsCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-WinPE-WinReCfg%", (Check-Boolean-ForWriteCommand($False)))
	$Base = $Base.Replace("%Support-Japanese-lp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-DismCmdlets_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-Dot3Svc_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-EnhancedStorage_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-HTA_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-LegacySetup_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-MDAC_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-NetFx_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-PowerShell_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-PPPoE_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-Rejuv_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-RNDIS_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-Scripting_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-SecureStartup_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-Setup_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-Setup-Client_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-Setup-Server_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-SRT_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-StorageWMI_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-WDS-Tools_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-WinReCfg_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese-WinPE-WMI_ja-jp%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	#$Base = $Base.Replace("%%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	$Base = $Base.Replace("%Support-Japanese%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("SupportJapaneseLanguageCheckBox").IsChecked)))
	
	#$Base = $Base.Replace("%%", (Check-Boolean-ForWriteCommand($MainWindow.FindName("").IsChecked)))
	
	return $Base
}

Function global:Create-BuildPeBatch
{
    # 読み込み
    $BaseBatchPath = Join-Path $BasedDirectory $BaseBatchPath
    $BaseBatch = Get-Content -Path $BaseBatchPath -Raw
	$BaseBatch = Replace-BuilderEnvironment $BaseBatch
    $global:LastBuildPeBatPath = Join-Path $global:ProjectDirectoryPath $BuildPeBatPath 
    Out-File -InputObject $BaseBatch -FilePath $global:LastBuildPeBatPath -Encoding default

    $CancelBatchPath = Join-Path $BasedDirectory $CancelBatchPath
    $CancelBaseBatch = Get-Content -Path $CancelBatchPath -Raw
	$CancelBaseBatch = Replace-BuilderEnvironment $CancelBaseBatch
    $global:LastCleanUpPeBatPath = Join-Path $global:ProjectDirectoryPath $CleanUpPeBatPath 
    Out-File -InputObject $CancelBaseBatch -FilePath $global:LastCleanUpPeBatPath -Encoding default
}

Function global:Begin-CreateBuildPeBatch
{
#$global:MainWindow.Dispather.BeginInvoke(
#[Action[string]] {
		$CopyWimFilePath = $MainWindow.FindName("WimPathTextBox").Text
		Create-BuildPeBatch
		start-process "cmd" -argumentlist ("/c","""",$LastBuildPeBatPath,"""") -verb runas -wait

		if ((Test-Path -Path $LastBuildPeBatPath) -eq $true)
		{
			#start-process "explorer" -argumentlist ("/n,/select,""{0}""" -f $LastBuildPeBatPath)
			start-process "explorer" -argumentlist ("/n,/select,""{0}""" -f $BuildedWindowsPePath)
		}
		else
		{
			start-process "cmd" -argumentlist ("/c","""",$LastCleanUpPeBatPath,"""") -verb runas -wait
		}

    #})



	$MainWindow.FindName("SaveButton").IsEnabled = $True
	$MainWindow.FindName("CancelButton").Visibility = [System.Windows.Visibility]::Visible
	$MainWindow.FindName("IndicatorRoot").Visibility = [System.Windows.Visibility]::Collapsed
}

Function global:Create-CopyWindowsReBatch
{
    # 読み込み
    $BaseBatchPath = Join-Path $BasedDirectory $BaseExportReFromWimPath
    $BaseBatch = Get-Content -Path $BaseBatchPath -Raw
	$BaseBatch = Replace-BuilderEnvironment $BaseBatch
    $global:LastBuildPeBatPath = Join-Path $global:ProjectDirectoryPath $ExportReBatPath 
    Out-File -InputObject $BaseBatch -FilePath $global:LastBuildPeBatPath -Encoding default
}

Function global:Begin-CopyWindowsReBatch
{
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    #$OpenFileDialog.Filter = "Windowsインストールイメージ|install.wim;install.esd"
	$OpenFileDialog.Filter = "Windowsインストールイメージ|install.wim"
    if($OpenFileDialog.ShowDialog() -ne "OK")
    {
        return
    }

	$Global:WindowsInstallWimPath = $OpenFileDialog.FileName

    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $SaveFileDialog.Filter = "WIMファイル (*.wim)|*.wim"
    if($SaveFileDialog.ShowDialog() -eq "OK")
    {
		$CopyWimFilePath = $SaveFileDialog.FileName
		Create-CopyWindowsReBatch
		start-process "cmd" -argumentlist ("/c","""",$LastBuildPeBatPath,"""") -verb runas -wait

		if ((Test-Path -Path $LastBuildPeBatPath) -eq $true)
		{
			start-process "explorer" -argumentlist ("/n,/select,""{0}""" -f $CopyWimFilePath)
			$MainWindow.FindName("WimPathTextBox").Text = $CopyWimFilePath
		}
        
    }


}