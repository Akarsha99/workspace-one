

$CurrentOS = Get-WmiObject -Class win32_operatingsystem |select -ExpandProperty caption

if($CurrentOS -like "*windows 11*")
{

if( (Test-Path "C:\script\PendingReboot-Afterwin11Upgrade\Rebootpendingyes.txt") -eq 'True')
{

#################################################################################
Add-Type -AssemblyName system.windows.Forms
Add-Type -AssemblyName System.Drawing
$monitor = [System.Windows.Forms.Screen]::PrimaryScreen
# Calculating the factors to multiply the Width and Height
$Form = New-Object system.windows.forms.form
$Form.Text = "Dear User, your device is all set for the Windows 11 upgrade!" 
$Font = New-Object System.Drawing.Font("Abadi",12,[System.Drawing.FontStyle]::Bold)
$Form.AutoSize = "True"
$Form.StartPosition = 'CenterScreen'
$Form.Font = $Font

 
$Label = New-Object System.Windows.Forms.Label
$Label.Location= New-Object System.Drawing.Point(10,30)
$Label.Text = "Please schedule a restart to kick off the automatic upgrade process, which 
might take approximately 40-60 minutes. It's 
important to avoid pressing any keys or performing hard shutdowns, while 
ensuring a stable power source and internet connection (Office network OR 
Broad band connection only) for a smooth Windows 11 installation."
$Label.ForeColor = "White"
$Label.AutoSize = $true
$Label.BackColor = "Transparent"
$objImage = [system.drawing.image]::FromFile("C:\script\PendingReboot-Afterwin11Upgrade\FinalImage4.ico")
$Form.BackgroundImage = $objImage
$Form.BackgroundImageLayout = "Stretch"
$Label1 = New-Object System.Windows.Forms.Label
$Label1.Location= New-Object System.Drawing.Point(10,320)
#$Label1.Text =""
$Label1.Text = "
Note: Do not use mobile hotspot/tethering during the Win11 update. 
If you require assistance, please contact GSD. We greatly appreciate
your cooperation and patience.

If no action is taken, Your device will Automatically initiate a forced
reboot after 24 hours. We kindly advice you to reboot your device well in
advance or plan your tasks accordingly to avoid any potential work disruption."
$Label1.ForeColor = "White"
$Label1.AutoSize = $true 
$Label1.BackColor = "Transparent"
 

#$Label.Location = New-Object System.Drawing.Size(70,65)
$Form.ControlBox = $False
$OK = New-Object System.Windows.Forms.Button
$OK.Location = New-Object System.Drawing.Point(250,475)
#$OK.ForeColor = "Maroon"
$OK.AutoSize = $True
$OK.Text = "I Understand"
$OK.DialogResult = [System.Windows.Forms.DialogResult]::OK
[System.Media.SystemSounds]::Hand.Play() 
$form.AcceptButton = $OK
$form.Controls.Add($OK)
$Form.Controls.Add($Label)
$Form.Controls.Add($Label1)
$result = $form.ShowDialog()


if($result -eq 'OK')
{
        if( (Test-Path "C:\script\PendingReboot-Afterwin11Upgrade\Rebootpendingyes.txt") -eq 'True')
        {
        $RebootPending = 'Yes'
        }
        else
        {
        $RebootPending = 'No'
        }

    if( (Test-Path "C:\script\PendingReboot-Afterwin11Upgrade\Userresponse.txt") -ne 'True')
    {
    try{New-Item -path "C:\script\" -Name PendingReboot-Afterwin11Upgrade -ItemType Directory -ErrorAction SilentlyContinue }catch{}
    "UserName,Userresponse,TriggerTime,HostName,RebootPendingState" |Out-File "C:\script\PendingReboot-Afterwin11Upgrade\Userresponse.txt" 
	
    }
    else
    {
    Write-Host "Not running"
    }

    Write-Host "Yes"
"$env:USERNAME"+',' +"$result"+',' + (get-date -Format dd-MMM-yyyy:hh:mm:ss)+ ';'+$env:COMPUTERNAME+';'+$RebootPending | Out-File "C:\script\PendingReboot-Afterwin11Upgrade\Userresponse.txt" -Append


}
else
{


}

}
else
{


}


Start-Sleep 60
if( (Test-Path "C:\script\PendingReboot-Afterwin11Upgrade\Rebootpendingyes.txt") -eq 'True')
{

    $differencetime = (Get-Date) - (Get-Item C:\Script\PendingReboot-Afterwin11Upgrade\OneDay.txt).CreationTime

    if($differencetime.Days -gt 0)
    {
        Add-Type -AssemblyName system.windows.Forms
        Add-Type -AssemblyName System.Drawing
        $monitor = [System.Windows.Forms.Screen]::PrimaryScreen
        # Calculating the factors to multiply the Width and Height
        $Form = New-Object system.windows.forms.form -property @{Topmost=$true}
        $Form.Text = "Dear User, your device is all set for the Windows 11 upgrade!" 
        $Font = New-Object System.Drawing.Font("Abadi",12,[System.Drawing.FontStyle]::Bold)
        $Form.AutoSize = "True"
        $Form.StartPosition = 'CenterScreen'
        $Form.Font = $Font
        $Label = New-Object System.Windows.Forms.Label
        $Label.Location= New-Object System.Drawing.Point(10,30)
        $Label.Text = "NOTE : The system is undergoing a scheduled force reboot, and your device
        will restart in 5 minutes. Please ensure to save your data/files."
        $Label.ForeColor = "White"
        $Label.AutoSize = $true
        $Label.BackColor = "Transparent"
        $objImage = [system.drawing.image]::FromFile("C:\script\PendingReboot-Afterwin11Upgrade\FinalImage4.ico")
        $Form.BackgroundImage = $objImage
        $Form.BackgroundImageLayout = "Stretch"
        #$Label.Location = New-Object System.Drawing.Size(70,65)
        $Form.ControlBox = $False
        $Form.Controls.Add($Label)
        $Form.TopMost = $true
        #$Form.Controls.Add($Label1)
		Restart-Computer -Force
		shutdown /r /t 300
        $form.ShowDialog()

        #Write-Host "Send Reboot Command"
        #shutdown /r /t 300


    }
    else
    {

    }


}

}


