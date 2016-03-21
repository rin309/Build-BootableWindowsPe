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
        $TextBox.Text = $SaveFileDialog.SelectedPath
        
    }
    else
    {
        
    }
}
