#
# Save_File.ps1
#

Function global:Save-File($TextBox, $Filter)
{
    $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    if ($TextBox.Text -ne $null) {
        $SaveFileDialog.FileName = $TextBox.Text
    }
    if ($Filter -ne $null) {
        $SaveFileDialog.Filter = $Filter
    }
    if($SaveFileDialog.ShowDialog() -eq "OK")
    {
        $TextBox.Text = $SaveFileDialog.FileName
        
    }
    else
    {
        
    }
}

Function global:Open-File($TextBox, $Filter)
{
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    if ($TextBox.Text -ne $null) {
        $OpenFileDialog.FileName = $TextBox.Text
    }
    if ($Filter -ne $null) {
        $OpenFileDialog.Filter = $Filter
    }
    if($OpenFileDialog.ShowDialog() -eq "OK")
    {
        $TextBox.Text = $OpenFileDialog.FileName
        
    }
    else
    {
        
    }
}
