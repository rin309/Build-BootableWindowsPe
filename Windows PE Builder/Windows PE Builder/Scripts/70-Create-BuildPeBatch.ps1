#
# Create_BuildPeBatch.ps1
#

Function global:Replace-BuilderEnvironment($Base)
{
    # 選択したプラットフォームを確認
    $Global:ProjectDirectoryPath = $MainWindow.FindName("ProjectPathTextBox").Text
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
    
    $Global:BuildedWindowsPePath = $MainWindow.FindName("SavePathTextBox").Text
    $Global:BuildedWindowsPePath = $BuildedWindowsPePath.Replace("%PlatformId%",$PlatformId)

	$Global:WinAdkPath = $MainWindow.FindName("WindowsAdkPathTextBox").Text

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
    $PeDirectory = Join-Path $Global:ProjectDirectoryPath "bin\"
    $PeDirectory = Join-Path $Global:ProjectDirectoryPath $PlatformId
    
    # 置換
    $Base = $Base.Replace("%ProjectDirectory%", $Global:ProjectDirectoryPath)
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
	
    $Base = $Base.Replace("%Support-WindowsInstallEsd%", (Check-Boolean-ForWriteCommand($Global:WindowsInstallEsdPath.Length -ne 0)))
	$Base = $Base.Replace("%WindowsInstallEsdPath%", $Global:WindowsInstallEsdPath)
	$Base = $Base.Replace("%WindowsInstallWimPath%", $Global:WindowsInstallWimPath)
    $Base = $Base.Replace("%Support-CopyWimFile%", (Check-Boolean-ForWriteCommand($Global:CopyWimFilePath.Length -ne 0)))
    $Base = $Base.Replace("%CopyWimFilePath%", $Global:CopyWimFilePath)
	

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
	$Global:WindowsInstallEsdPath = ""
    # 読み込み
    $BaseBatchPath = Join-Path $BasedDirectory $BaseBatchPath
    $BaseBatch = Get-Content -Path $BaseBatchPath -Raw
	$BaseBatch = Replace-BuilderEnvironment $BaseBatch
    $Global:LastBuildPeBatPath = Join-Path $Global:ProjectDirectoryPath $BuildPeBatPath 
    Out-File -InputObject $BaseBatch -FilePath $Global:LastBuildPeBatPath -Encoding default

    $CancelBatchPath = Join-Path $BasedDirectory $CancelBatchPath
    $CancelBaseBatch = Get-Content -Path $CancelBatchPath -Raw
	$CancelBaseBatch = Replace-BuilderEnvironment $CancelBaseBatch
    $Global:LastCleanUpPeBatPath = Join-Path $Global:ProjectDirectoryPath $CleanUpPeBatPath 
    Out-File -InputObject $CancelBaseBatch -FilePath $Global:LastCleanUpPeBatPath -Encoding default
}

Function global:Begin-CreateBuildPeBatch
{
#$Global:MainWindow.Dispather.BeginInvoke(
#[Action[string]] {
		$Global:CopyWimFilePath = $MainWindow.FindName("WimPathTextBox").Text
		Create-BuildPeBatch
		start-process "cmd" -argumentlist ("/c","""",$LastBuildPeBatPath,"""") -verb runas -wait

		if ((Test-Path -Path $BuildedWindowsPePath) -eq $true)
		{
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
    $Global:LastBuildPeBatPath = Join-Path $Global:ProjectDirectoryPath $ExportReBatPath 
    Out-File -InputObject $BaseBatch -FilePath $Global:LastBuildPeBatPath -Encoding default
}

Function global:Begin-CopyWindowsReBatch
{
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Filter = "Windowsインストールイメージ|install.wim;install.esd"
    if($OpenFileDialog.ShowDialog() -ne "OK")
    {
        return
    }

    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $SaveFileDialog.FileName = "Original-Winre.wim"
    if ($MainWindow.FindName("ProjectPathTextBox").Text -ne $null) {
        $SaveFileDialog.InitialDirectory = $MainWindow.FindName("ProjectPathTextBox").Text
    }
    $SaveFileDialog.Filter = "WIMファイル (*.wim)|*.wim"
    if($SaveFileDialog.ShowDialog() -eq "OK")
    {
		$Global:CopyWimFilePath = $SaveFileDialog.FileName

		if ($(Get-ChildItem $OpenFileDialog.FileName).get_Extension().ToLower() -eq ".esd"){
			$Global:WindowsInstallEsdPath = $OpenFileDialog.FileName
			$Global:WindowsInstallWimPath = $Global:CopyWimFilePath,"-Source.wim"
		}
		else{
			$Global:WindowsInstallEsdPath = ""
			$Global:WindowsInstallWimPath = $OpenFileDialog.FileName
		}

		Create-CopyWindowsReBatch
		start-process "cmd" -argumentlist ("/c","""",$LastBuildPeBatPath,"""") -verb runas -wait

		if ((Test-Path -Path $LastBuildPeBatPath) -eq $true)
		{
			$MainWindow.FindName("WimPathTextBox").Text = $Global:CopyWimFilePath
		}
        
    }


}