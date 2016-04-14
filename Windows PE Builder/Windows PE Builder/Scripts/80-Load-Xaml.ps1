#
# Load_Xaml.ps1
#

Function global:Read-Xaml($Path)
{
    $XamlPath = Join-Path $BasedDirectory $Path
    $Xaml = [System.IO.File]::ReadAllText($XamlPath, [System.Text.Encoding]::UTF8)
    $Xaml = $Xaml.Replace("%BasedDirectory%", $BasedDirectory)
    return [System.Windows.Markup.XamlReader]::Parse($Xaml)
}

Function global:Check-SaveAvailable($MainWindow)
{
    $WindowsAdkPathTextBox = $MainWindow.FindName("WindowsAdkPathTextBox")
    $SavePathTextBox = $MainWindow.FindName("SavePathTextBox")
    $ProjectPathTextBox = $MainWindow.FindName("ProjectPathTextBox")
    
    $ExportWindowsReImageButton = $MainWindow.FindName("ExportWindowsReImageButton")
    $SaveButton = $MainWindow.FindName("SaveButton")
    if (($WindowsAdkPathTextBox.Text -ne "") -and ($SavePathTextBox.Text -ne "") -and ($ProjectPathTextBox.Text -ne ""))
    {
        $ExportWindowsReImageButton.IsEnabled = $true
        $SaveButton.IsEnabled = $true
    }
    else
    {
        $ExportWindowsReImageButton.IsEnabled = $false
        $SaveButton.IsEnabled = $false
    }
}


Function global:Check-WindowsPeFeature($WindowsReIsEnabled, $PowershellIsEnabled)
{
	if (($WindowsReIsEnabled -eq $true) -and ($PowershellIsEnabled -eq $true))
	{
		$MainWindow.FindName("SupportWmiCheckBox").IsChecked = $True
		#$MainWindow.FindName("SupportWindowsFoundationPackageCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportEsCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportRejuvCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportScriptingCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSecureStartupCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSetupCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSrtCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportWdsCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportStorageWmiCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportHtaCheckBox").IsChecked = $True

		$MainWindow.FindName("SupportNetFxCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportDismCmdletsCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSecureBootCmdletsCheckBox").IsChecked = $True
	}
	elseif (($WindowsReIsEnabled -eq $true) -and ($PowershellIsEnabled -eq $false))
	{
		$MainWindow.FindName("SupportWmiCheckBox").IsChecked = $True
		#$MainWindow.FindName("SupportWindowsFoundationPackageCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportEsCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportRejuvCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportScriptingCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSecureStartupCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSetupCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSrtCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportWdsCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportStorageWmiCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportHtaCheckBox").IsChecked = $True

		$MainWindow.FindName("SupportNetFxCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportDismCmdletsCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportSecureBootCmdletsCheckBox").IsChecked = $false
	}
	elseif (($WindowsReIsEnabled -eq $false) -and ($PowershellIsEnabled -eq $true))
	{
		#$MainWindow.FindName("SupportWindowsFoundationPackageCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportEsCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportRejuvCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportSecureStartupCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportSetupCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportSrtCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportWdsCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportStorageWmiCheckBox").IsChecked = $true
		$MainWindow.FindName("SupportHtaCheckBox").IsChecked = $false

		$MainWindow.FindName("SupportWmiCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportNetFxCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportScriptingCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportDismCmdletsCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSecureBootCmdletsCheckBox").IsChecked = $True
	}
	else
	{
		$MainWindow.FindName("SupportWmiCheckBox").IsChecked = $false
		#$MainWindow.FindName("SupportWindowsFoundationPackageCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportEsCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportRejuvCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportScriptingCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportSecureStartupCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportSetupCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportSrtCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportWdsCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportStorageWmiCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportHtaCheckBox").IsChecked = $false

		$MainWindow.FindName("SupportNetFxCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportDismCmdletsCheckBox").IsChecked = $false
		$MainWindow.FindName("SupportSecureBootCmdletsCheckBox").IsChecked = $false
	}
}

Function global:Open-Browser($Uri)
{
	Start-Process $Uri

}

function global:InitializingAdkComBox()
{
	$IsAdkInstalledEnvironment = $false
	$IsMultipleAdkEnvironment = $false

	# 使用中のプラットフォームによる差異を確認
	if ([Environment]::Is64BitProcess -eq $true)
	{
		if ((Test-Path -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots") -eq $true)
		{
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots").KitsRoot
			if ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk8ComboBoxItem").Tag = $KitsRoot
				$IsAdkInstalledEnvironment = $true
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk8ComboBoxItem")
			}
			else
			{
				$MainWindow.FindName("Adk8ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots").KitsRoot81
			if ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk81ComboBoxItem").Tag = $KitsRoot
				if ($IsAdkInstalledEnvironment -eq $true)
				{
					$IsMultipleAdkEnvironment = $true
				}
				$IsAdkInstalledEnvironment = $true
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk81ComboBoxItem")
			}
			else
			{
				$MainWindow.FindName("Adk81ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots").KitsRoot10
			if ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk10ComboBoxItem").Tag = $KitsRoot
				if ($IsAdkInstalledEnvironment -eq $true)
				{
					$IsMultipleAdkEnvironment = $true
				}
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk10ComboBoxItem")
			}
			else
			{
				$MainWindow.FindName("Adk10ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
		}
	}
	else
	{
		if ((Test-Path -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots") -eq $true)
		{
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots").KitsRoot
			if ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk8ComboBoxItem").Tag = $KitsRoot
				$IsAdkInstalledEnvironment = $true
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk8ComboBoxItem")
			}
			else
			{
				$MainWindow.FindName("Adk8ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots").KitsRoot81
			if ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk81ComboBoxItem").Tag = $KitsRoot
				if ($IsAdkInstalledEnvironment -eq $true)
				{
					$IsMultipleAdkEnvironment = $true
				}
				$IsAdkInstalledEnvironment = $true
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk81ComboBoxItem")
			}
			else
			{
				$MainWindow.FindName("Adk81ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots").KitsRoot10
			if ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk10ComboBoxItem").Tag = $KitsRoot
				if ($IsAdkInstalledEnvironment -eq $true)
				{
					$IsMultipleAdkEnvironment = $true
				}
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk10ComboBoxItem")
			}
			else
			{
				$MainWindow.FindName("Adk10ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
		}
	}

	if ($IsMultipleAdkEnvironment -eq $false)
	{
		$MainWindow.FindName("SelectAdkRoot").Visibility = [System.Windows.Visibility]::Collapsed
	}
}



Function global:Load-Xaml()
{
    $Global:MainWindow = Read-Xaml("View/MainWindow.xaml")

    $WindowsAdkPathButton = $MainWindow.FindName("WindowsAdkPathButton")
    $WindowsAdkPathButton.Add_Click({
        $WindowsAdkPathTextBox = $MainWindow.FindName("WindowsAdkPathTextBox")
        Select-Folder($WindowsAdkPathTextBox)
        Check-SaveAvailable($MainWindow)
    })
    $WimPathButton = $MainWindow.FindName("WimPathButton")
    $WimPathButton.Add_Click({
        $WimPathTextBox = $MainWindow.FindName("WimPathTextBox")
        Open-File $WimPathTextBox "WIMファイル (*.wim)|*.wim"
        Check-SaveAvailable($MainWindow)
    })
    $Option1PathButton = $MainWindow.FindName("Option1PathButton")
    $Option1PathButton.Add_Click({
        $Option1PathTextBox = $MainWindow.FindName("Option1PathTextBox")
        Select-Folder($Option1PathTextBox)
        Check-SaveAvailable($MainWindow)
    })
    $Option2PathButton = $MainWindow.FindName("Option2PathButton")
    $Option2PathButton.Add_Click({
        $Option2PathTextBox = $MainWindow.FindName("Option2PathTextBox")
        Select-Folder($Option2PathTextBox)
        Check-SaveAvailable($MainWindow)
    })
    $SavePathButton = $MainWindow.FindName("SavePathButton")
    $SavePathButton.Add_Click({
        $SavePathTextBox = $MainWindow.FindName("SavePathTextBox")
        Save-File $SavePathTextBox "ISOイメージ (*.iso)|*.iso"
        Check-SaveAvailable($MainWindow)
    })
    $ProjectPathButton = $MainWindow.FindName("ProjectPathButton")
    $ProjectPathButton.Add_Click({
        $ProjectPathTextBox = $MainWindow.FindName("ProjectPathTextBox")
        Select-Folder($ProjectPathTextBox)
        Check-SaveAvailable($MainWindow)
    })
    
    $MainWindow.FindName("Hyperlink1").Add_Click({
        Open-Browser($MainWindow.FindName("Hyperlink1").NavigateUri)
    })
    $MainWindow.FindName("Hyperlink2").Add_Click({
        Open-Browser($MainWindow.FindName("Hyperlink2").NavigateUri)
    })
    $MainWindow.FindName("Hyperlink3").Add_Click({
        Open-Browser($MainWindow.FindName("Hyperlink3").NavigateUri)
    })
    $MainWindow.FindName("Hyperlink4").Add_Click({
        Open-Browser($MainWindow.FindName("Hyperlink4").NavigateUri)
    })
    $MainWindow.FindName("Hyperlink101").Add_Click({
        Open-Browser($MainWindow.FindName("Hyperlink101").NavigateUri)
    })
    $MainWindow.FindName("Hyperlink102").Add_Click({
        Open-Browser($MainWindow.FindName("Hyperlink102").NavigateUri)
    })
    $MainWindow.FindName("Hyperlink111").Add_Click({
        Open-Browser($MainWindow.FindName("Hyperlink111").NavigateUri)
    })
    $MainWindow.FindName("Hyperlink112").Add_Click({
        Open-Browser($MainWindow.FindName("Hyperlink112").NavigateUri)
    })
    $MainWindow.FindName("AboutHyperlink").Add_Click({
        Open-Browser($MainWindow.FindName("AboutHyperlink").NavigateUri)
    })

	#Windows RE
	<#$MainWindow.FindName("SupportWindowsReCheckBox").Add_Checked({Check-WindowsPeFeature $MainWindow.FindName("SupportWindowsReCheckBox").IsChecked $MainWindow.FindName("SupportPsCheckBox").IsChecked })
	$MainWindow.FindName("SupportWindowsReCheckBox").Add_UnChecked({Check-WindowsPeFeature $MainWindow.FindName("SupportWindowsReCheckBox").IsChecked $MainWindow.FindName("SupportPsCheckBox").IsChecked })#>
	
	#PowerShell
	$MainWindow.FindName("SupportPsCheckBox").Add_Checked({Check-WindowsPeFeature $MainWindow.FindName("SupportWindowsReCheckBox").IsChecked $MainWindow.FindName("SupportPsCheckBox").IsChecked })
	$MainWindow.FindName("SupportPsCheckBox").Add_UnChecked({Check-WindowsPeFeature $MainWindow.FindName("SupportWindowsReCheckBox").IsChecked $MainWindow.FindName("SupportPsCheckBox").IsChecked })


    $ProjectPathTextBox = $MainWindow.FindName("ProjectPathTextBox")
    $ProjectPathTextBox.Add_TextChanged({
        if ($ProjectPathTextBox.Text -ne "")
        {
            $SavePathTextBox = $MainWindow.FindName("SavePathTextBox")
            $SavePathTextBox.Text = Join-Path $ProjectPathTextBox.Text $BuildedWindowsPePath
        }
        Check-SaveAvailable($MainWindow)
    })
    $SaveButton = $MainWindow.FindName("SaveButton")
    $SaveButton.Add_Click({
		$SaveButton = $MainWindow.FindName("SaveButton")
		$SaveButton.IsEnabled = $False
		$MainWindow.FindName("IndicatorRoot").Visibility = [System.Windows.Visibility]::Visible
		$MainWindow.DialogResult = $True
		$MainWindow.Close() 
    })

    $ExportWindowsReImageButton = $MainWindow.FindName("ExportWindowsReImageButton")
    $ExportWindowsReImageButton.Add_Click({
		Begin-CopyWindowsReBatch
    })

    $SaveButton = $MainWindow.FindName("CancelButton")
    $SaveButton.Add_Click({
        Remove-Item $BuildedWindowsPePath
		$MainWindow.FindName("CancelButton").Visibility = [System.Windows.Visibility]::Collapsed
    })
	
    $SaveButton = $MainWindow.FindName("AgreeButton")
    $SaveButton.Add_Click({
		$MainWindow.FindName("EulaRoot").Visibility = [System.Windows.Visibility]::Collapsed
    })
	
    $SaveButton = $MainWindow.FindName("ExitButton")
    $SaveButton.Add_Click({
		$MainWindow.DialogResult = $False
		$MainWindow.Close() 
    })
	
    $SelectAdkComboBox = $MainWindow.FindName("SelectAdkComboBox")
    $SelectAdkComboBox.Add_SelectionChanged({
		$MainWindow.FindName("WindowsAdkPathTextBox").Text = Extis-Path($MainWindow.FindName("SelectAdkComboBox").SelectedItem.Tag)
    })

    $MainWindow.FindName("Option1PathTextBox").Text = $Global:GhostPath
    $MainWindow.FindName("Option2PathTextBox").Text = $Global:Option2Path
    $MainWindow.FindName("ProjectPathTextBox").Text = $Global:ProjectDirectoryPath

    Check-SaveAvailable($MainWindow)

    $MainWindow.Title = $ApplicationTitle
    $MainWindow.FindName("ApplicationTitleTextBlock").Text = $ApplicationTitle
    $MainWindow.FindName("ApplicationLastUpdatedTextBlock").Text = $LastUpdated
    $MainWindow.FindName("AuthorTextBlock").Text = $Author

	InitializingAdkComBox

    return $MainWindow
}
