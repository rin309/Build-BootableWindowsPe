#
# Load_Xaml.ps1
#

Function Global:Read-Xaml($Path)
{
    $XamlPath = Join-Path $BasedDirectory $Path
    $Xaml = [System.IO.File]::ReadAllText($XamlPath, [System.Text.Encoding]::UTF8)
    $Xaml = $Xaml.Replace("%BasedDirectory%", $BasedDirectory)
    Return [System.Windows.Markup.XamlReader]::Parse($Xaml)
}

Function Global:Check-SaveAvailable($MainWindow)
{
    $WindowsAdkPathTextBox = $MainWindow.FindName("WindowsAdkPathTextBox")
    $SavePathTextBox = $MainWindow.FindName("SavePathTextBox")
    $ProjectPathTextBox = $MainWindow.FindName("ProjectPathTextBox")
    
    $ExportWindowsReImageButton = $MainWindow.FindName("ExportWindowsReImageButton")
    $SaveButton = $MainWindow.FindName("SaveButton")
    $CreateProjectOkButton = $MainWindow.FindName("CreateProjectOkButton")
    If (($WindowsAdkPathTextBox.Text -ne "") -and ($SavePathTextBox.Text -ne "") -and ($ProjectPathTextBox.Text -ne ""))
    {
        $ExportWindowsReImageButton.IsEnabled = $True
        $SaveButton.IsEnabled = $True
		$CreateProjectOkButton.IsEnabled = $True
    }
    Else
    {
        $ExportWindowsReImageButton.IsEnabled = $False
        $SaveButton.IsEnabled = $False
		$CreateProjectOkButton.IsEnabled = $False
    }
}


Function Global:Check-WindowsPeFeature($WindowsReIsEnabled, $PowershellIsEnabled)
{
	If (($WindowsReIsEnabled -eq $True) -and ($PowershellIsEnabled -eq $True))
	{
		$MainWindow.FindName("SupportWmiCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportWindowsFoundationPackageCheckBox").IsChecked = $True
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
	ElseIf (($WindowsReIsEnabled -eq $True) -and ($PowershellIsEnabled -eq $False))
	{
		$MainWindow.FindName("SupportWmiCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportWindowsFoundationPackageCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportEsCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportRejuvCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportScriptingCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSecureStartupCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSetupCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSrtCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportWdsCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportStorageWmiCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportHtaCheckBox").IsChecked = $True

		$MainWindow.FindName("SupportNetFxCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportDismCmdletsCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportSecureBootCmdletsCheckBox").IsChecked = $False
	}
	ElseIf (($WindowsReIsEnabled -eq $False) -and ($PowershellIsEnabled -eq $True))
	{
		$MainWindow.FindName("SupportWindowsFoundationPackageCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportEsCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportRejuvCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportSecureStartupCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportSetupCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportSrtCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportWdsCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportStorageWmiCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportHtaCheckBox").IsChecked = $False

		$MainWindow.FindName("SupportWmiCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportNetFxCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportScriptingCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportDismCmdletsCheckBox").IsChecked = $True
		$MainWindow.FindName("SupportSecureBootCmdletsCheckBox").IsChecked = $True
	}
	Else
	{
		$MainWindow.FindName("SupportWmiCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportWindowsFoundationPackageCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportEsCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportRejuvCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportScriptingCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportSecureStartupCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportSetupCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportSrtCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportWdsCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportStorageWmiCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportHtaCheckBox").IsChecked = $False

		$MainWindow.FindName("SupportNetFxCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportDismCmdletsCheckBox").IsChecked = $False
		$MainWindow.FindName("SupportSecureBootCmdletsCheckBox").IsChecked = $False
	}
}

Function Global:Open-Browser($Uri)
{
	Start-Process $Uri

}

Function Global:InitializingAdkComBox()
{
	$IsAdkInstalledEnvironment = $False
	$IsMultipleAdkEnvironment = $False

	# 使用中のプラットフォームによる差異を確認
	If ([Environment]::Is64BitProcess -eq $True)
	{
		If ((Test-Path -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots") -eq $True)
		{
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots").KitsRoot
			If ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk8ComboBoxItem").Tag = $KitsRoot
				$IsAdkInstalledEnvironment = $True
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk8ComboBoxItem")
			}
			Else
			{
				$MainWindow.FindName("Adk8ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots").KitsRoot81
			If ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk81ComboBoxItem").Tag = $KitsRoot
				If ($IsAdkInstalledEnvironment -eq $True)
				{
					$IsMultipleAdkEnvironment = $True
				}
				$IsAdkInstalledEnvironment = $True
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk81ComboBoxItem")
			}
			Else
			{
				$MainWindow.FindName("Adk81ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Wow6432Node\Microsoft\Windows Kits\Installed Roots").KitsRoot10
			If ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk10ComboBoxItem").Tag = $KitsRoot
				If ($IsAdkInstalledEnvironment -eq $True)
				{
					$IsMultipleAdkEnvironment = $True
				}
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk10ComboBoxItem")
			}
			Else
			{
				$MainWindow.FindName("Adk10ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
		}
	}
	Else
	{
		If ((Test-Path -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots") -eq $True)
		{
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots").KitsRoot
			If ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk8ComboBoxItem").Tag = $KitsRoot
				$IsAdkInstalledEnvironment = $True
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk8ComboBoxItem")
			}
			Else
			{
				$MainWindow.FindName("Adk8ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots").KitsRoot81
			If ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk81ComboBoxItem").Tag = $KitsRoot
				If ($IsAdkInstalledEnvironment -eq $True)
				{
					$IsMultipleAdkEnvironment = $True
				}
				$IsAdkInstalledEnvironment = $True
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk81ComboBoxItem")
			}
			Else
			{
				$MainWindow.FindName("Adk81ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
			$KitsRoot = $(Get-ItemProperty -Path HKLM:"SOFTWARE\Microsoft\Windows Kits\Installed Roots").KitsRoot10
			If ($KitsRoot -ne $null)
			{
				$MainWindow.FindName("Adk10ComboBoxItem").Tag = $KitsRoot
				If ($IsAdkInstalledEnvironment -eq $True)
				{
					$IsMultipleAdkEnvironment = $True
				}
				$MainWindow.FindName("SelectAdkComboBox").SelectedItem = $MainWindow.FindName("Adk10ComboBoxItem")
			}
			Else
			{
				$MainWindow.FindName("Adk10ComboBoxItem").Visibility = [System.Windows.Visibility]::Collapsed
			}
		}
	}

	If ($IsMultipleAdkEnvironment -eq $False)
	{
		$MainWindow.FindName("SelectAdkRoot").Visibility = [System.Windows.Visibility]::Collapsed
	}
}



Function Global:Load-Xaml()
{
    $Script:MainWindow = Read-Xaml("View/MainWindow.xaml")

	$MainWindow.FindName("CreateProjectRoot").Visibility = [System.Windows.Visibility]::Visible
	$MainWindow.FindName("EulaRoot").Visibility = [System.Windows.Visibility]::Visible

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
	$MainWindow.FindName("SupportWindowsReCheckBox").Add_Checked({
		Check-WindowsPeFeature $MainWindow.FindName("SupportWindowsReCheckBox").IsChecked $MainWindow.FindName("SupportPsCheckBox").IsChecked
	})
	$MainWindow.FindName("SupportWindowsReCheckBox").Add_UnChecked({
		Check-WindowsPeFeature $MainWindow.FindName("SupportWindowsReCheckBox").IsChecked $MainWindow.FindName("SupportPsCheckBox").IsChecked
	})
	
	#PowerShell
	$MainWindow.FindName("SupportPsCheckBox").Add_Checked({
		Check-WindowsPeFeature $MainWindow.FindName("SupportWindowsReCheckBox").IsChecked $MainWindow.FindName("SupportPsCheckBox").IsChecked
	})
	$MainWindow.FindName("SupportPsCheckBox").Add_UnChecked({
		Check-WindowsPeFeature $MainWindow.FindName("SupportWindowsReCheckBox").IsChecked $MainWindow.FindName("SupportPsCheckBox").IsChecked
	})


    $ProjectPathTextBox = $MainWindow.FindName("ProjectPathTextBox")
    $ProjectPathTextBox.Add_TextChanged({
        If ($ProjectPathTextBox.Text -ne "")
        {
			$Script:ProjectDirectoryPath = $ProjectPathTextBox.Text
            $SavePathTextBox = $MainWindow.FindName("SavePathTextBox")
            $SavePathTextBox.Text = Join-Path $ProjectDirectoryPath $BuildedWindowsPePath
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
	
	$CreateProjectOkButton = $MainWindow.FindName("CreateProjectOkButton")
    $CreateProjectOkButton.Add_Click({
		$MainWindow.FindName("CreateProjectRoot").Visibility = [System.Windows.Visibility]::Collapsed
		Copy-Item (Join-Path $BasedDirectory "Templates\*") $ProjectDirectoryPath -Recurse -Force
    })

    $SaveButton = $MainWindow.FindName("AgreeButton")
    $SaveButton.Add_Click({
		$MainWindow.FindName("EulaRoot").Visibility = [System.Windows.Visibility]::Collapsed
    })

	If ($Script:LicenseAgreement){
		$MainWindow.FindName("EulaRoot").Visibility = [System.Windows.Visibility]::Collapsed
	}
	
    $SaveButton = $MainWindow.FindName("ExitButton")
    $SaveButton.Add_Click({
		$MainWindow.DialogResult = $False
		$MainWindow.Close() 
    })
	
    $SelectAdkComboBox = $MainWindow.FindName("SelectAdkComboBox")
    $SelectAdkComboBox.Add_SelectionChanged({
		$MainWindow.FindName("WindowsAdkPathTextBox").Text = Extis-Path($MainWindow.FindName("SelectAdkComboBox").SelectedItem.Tag)
    })

    $MainWindow.FindName("DriversPathTextBox").Text = $DriverDirectoryPath
    $MainWindow.FindName("Option1PathTextBox").Text = $GhostPath
    $MainWindow.FindName("Option2PathTextBox").Text = $Option2Path
    $MainWindow.FindName("ProjectPathTextBox").Text = $ProjectDirectoryPath

    Check-SaveAvailable($MainWindow)

    $MainWindow.Title = $ApplicationTitle
    $MainWindow.FindName("ApplicationTitleTextBlock").Text = $ApplicationTitle
    $MainWindow.FindName("ApplicationLastUpdatedTextBlock").Text = $LastUpdated
    $MainWindow.FindName("AuthorTextBlock").Text = $Author

	InitializingAdkComBox

    Return $MainWindow
}
