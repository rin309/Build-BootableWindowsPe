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
    
    $SaveButton = $MainWindow.FindName("SaveButton")
    if (($WindowsAdkPathTextBox.Text -ne "") -and ($SavePathTextBox.Text -ne "") -and ($ProjectPathTextBox.Text -ne ""))
    {
        $SaveButton.IsEnabled = $true
    }
    else
    {
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


Function global:Load-Xaml()
{
    #$ThemeResource = Read-Xaml("Assets/ThemeResource.xaml")
    #$StyleResource = Read-Xaml("Assets/StyleResource.xaml")
    #$NavigationTabResource = Read-Xaml("Assets/NavigationTabResource.xaml")
    
    $global:MainWindow = Read-Xaml("View/MainWindow.xaml")

    $WindowsAdkPathButton = $MainWindow.FindName("WindowsAdkPathButton")
    $WindowsAdkPathButton.Add_Click({
        $WindowsAdkPathTextBox = $MainWindow.FindName("WindowsAdkPathTextBox")
        Select-Folder($WindowsAdkPathTextBox)
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
        Save-File $SavePathTextBox "ISOÉCÉÅÅ[ÉW (*.iso)|*.iso"
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
        Begin-CreateBuildPeBatch
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

    $MainWindow.FindName("WindowsAdkPathTextBox").Text = Extis-Path($WinAdkPath)
    $MainWindow.FindName("Option1PathTextBox").Text = $global:GhostPath
    $MainWindow.FindName("Option2PathTextBox").Text = $global:Option2Path
    $MainWindow.FindName("ProjectPathTextBox").Text = $global:ProjectDirectoryPath

    Check-SaveAvailable($MainWindow)

    $MainWindow.Title = $ApplicationTitle
    $MainWindow.FindName("ApplicationTitleTextBlock").Text = $ApplicationTitle
    $MainWindow.FindName("ApplicationLastUpdatedTextBlock").Text = $LastUpdated
    $MainWindow.FindName("AuthorTextBlock").Text = $Author


    return $MainWindow
}
