

Del "C:\script\PendingReboot-Afterwin11Upgrade\User-PendingReboot-afterwin11Upgrade.ps1" /Q
copy "$PSScriptRoot\User-PendingReboot-afterwin11Upgrade.ps1" "C:\script\PendingReboot-Afterwin11Upgrade"
$result = $null

    $result = schtasks /query |findstr "PendingReboot-Afterwin11Upgrade"
    if($result)
    {

    [Environment]::Exit(777) 

    }
    else
    {

    [Environment]::Exit(666)

    }

