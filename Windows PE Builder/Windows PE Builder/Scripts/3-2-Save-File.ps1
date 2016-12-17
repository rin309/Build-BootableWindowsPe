#
# Save_File.ps1
#

Function Global:Save-File($TextBox, $Filter)
{
    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    If ($TextBox.Text -ne $null) {
        $SaveFileDialog.FileName = $TextBox.Text
    }
    If ($Filter -ne $null) {
        $SaveFileDialog.Filter = $Filter
    }
    if($SaveFileDialog.ShowDialog() -eq "OK")
    {
        $TextBox.Text = $SaveFileDialog.FileName
        
    }
    Else
    {
        
    }
}

Function Global:Open-File($TextBox, $Filter)
{
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    If ($TextBox.Text -ne $null) {
        $OpenFileDialog.FileName = $TextBox.Text
    }
    If ($Filter -ne $null) {
        $OpenFileDialog.Filter = $Filter
    }
    if($OpenFileDialog.ShowDialog() -eq "OK")
    {
        $TextBox.Text = $OpenFileDialog.FileName
        
    }
    Else
    {
        
    }
}
