usoclient startinteractivescan
Remove-Item C:\script\PendingReboot-Afterwin11Upgrade\Rebootpendingyes.txt -force -confirm:$false

$CurrentOS = Get-WmiObject -Class win32_operatingsystem |select -ExpandProperty caption

if($CurrentOS -like "*windows 11*")
{
$UserName = "CORP\"+(Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\JoinInfo\*"|select -ExpandProperty Useremail).split('@')[0]
$objUser = New-Object System.Security.Principal.NTAccount("$UserName")
$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
$accountName = $strSID.Value

if($accountName ){$accountName = $strSID.Value}else{$accountName = $null}
Remove-Item "C:\script\PendingReboot-Afterwin11Upgrade\Rebootpendingyes.txt" -Force

$updateresult = Get-WUList
if(!$updateresult)
{
Import-Module -Name "C:\Program Files\WindowsPowerShell\Modules\PSWindowsUpdate\2.4.0.2\PSWindowsUpdate.psm1" -Verbose

Start-Sleep 10
}


$Result = $updateresult| ?{$_.title -like 'Windows 11,*'} 

if( ($Result.Title -like "Windows 11, version*") -and ($Result.RebootRequired -eq 'True') )
{
    New-Item C:\script\PendingReboot-Afterwin11Upgrade\Rebootpendingyes.txt
        if(!(Test-Path C:\Script\PendingReboot-Afterwin11Upgrade\OneDay.txt))
        {
        New-Item C:\script\PendingReboot-Afterwin11Upgrade\OneDay.txt
        }
    $accountName |Set-Content  C:\script\PendingReboot-Afterwin11Upgrade\Rebootpendingyes.txt
}
else
{
Remove-Item C:\script\PendingReboot-Afterwin11Upgrade\OneDay.txt -Force
}
}
# Check the Windows name
$windowsVersion = (Get-ComputerInfo).OsVersion
 
# Define the Windows Name criteria for your actions
$desiredWindowsVersion = "10.0.26100"  # Replace with your desired Windows Name

# Compare versions
if ($windowsVersion -like $desiredWindowsVersion) {
    # Perform actions specific to the supported Windows Name

    Write-Host "Feature added successfully on Windows version $($windowsVersion)"
} else {
    Write-Host "This feature requires Windows version $($desiredRequiredVersion) or newer."
}



    