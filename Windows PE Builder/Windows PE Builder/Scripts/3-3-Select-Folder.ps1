#
# Select-Folder
#

Function Global:Select-Folder($TextBox)
{
	#If ([System.Environment]::OSVersion.Version.Major -ge 6)
	#{
		
	#}
	#Else
	#{
		$FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
		If ($TextBox.Text -ne $null) {
			$FolderBrowserDialog.SelectedPath = $TextBox.Text
		}
		if($FolderBrowserDialog.ShowDialog() -eq "OK")
		{
			$TextBox.Text = $FolderBrowserDialog.SelectedPath
		}
		Else
		{
		}
	#}

}