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

