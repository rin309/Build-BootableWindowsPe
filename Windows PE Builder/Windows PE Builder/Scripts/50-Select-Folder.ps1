#
# Select-Folder
#

Function global:Select-Folder($TextBox)
{
	#if ([System.Environment]::OSVersion.Version.Major -ge 6)
	#{
		
	#}
	#else
	#{
		$FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
		if ($TextBox.Text -ne $null) {
			$FolderBrowserDialog.SelectedPath = $TextBox.Text
		}
		if($FolderBrowserDialog.ShowDialog() -eq "OK")
		{
			$TextBox.Text = $FolderBrowserDialog.SelectedPath
		}
		else
		{
		}
	#}

}