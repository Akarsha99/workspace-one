New-Item "C:\Program Files\WindowsPowerShell\Modules" -Name PSWindowsUpdate -ItemType Directory -Force

Copy-Item -Path "$PSScriptRoot\PSWindowsUpdate\*" "C:\Program Files\WindowsPowerShell\Modules\PSWindowsUpdate" -Force -Recurse

$UserID = powershell -executionpolicy bypass -file $PSScriptRoot\Get-UserID.ps1
$data = Get-Content $PSScriptRoot\User-PendingReboot-Win11Upgrade.Xml
$data -replace "<UserId>S-1-5-18</UserId>","<UserId>$UserID</UserId>"|Set-Content $PSScriptRoot\User-PendingReboot-Win11Upgrade.Xml
#$data -replace "<UserId>S-1-5-18</UserId>","<UserId>$UserID</UserId>"|Set-Content $PSScriptRoot\User-PendingReboot-Win11Upgrade.Xml
#::Create a task to run weekly once
schtasks /create /xml "$PSScriptRoot\System-PendingReboot-Win11Upgrade.Xml" /tn "System-PendingReboot-Afterwin11Upgrade"
schtasks /create /xml "$PSScriptRoot\User-PendingReboot-Win11Upgrade.Xml" /tn "User-PendingReboot-Afterwin11Upgrade"

try{mkdir "C:\script\PendingReboot-Afterwin11Upgrade" -ErrorAction SilentlyContinue }catch{}
copy "$PSScriptRoot\User-PendingReboot-afterwin11Upgrade.ps1" "C:\script\PendingReboot-Afterwin11Upgrade"
copy "$PSScriptRoot\System-PendingReboot-afterwin11Upgrade.ps1" "C:\script\PendingReboot-Afterwin11Upgrade"
copy "$PSScriptRoot\Execute.bat" "C:\script\PendingReboot-Afterwin11Upgrade"
copy "$PSScriptRoot\UserExecute.bat" "C:\script\PendingReboot-Afterwin11Upgrade"
copy "$PSScriptRoot\FinalImage4.ico" "C:\script\PendingReboot-Afterwin11Upgrade"

schtasks /TN System-PendingReboot-Afterwin11Upgrade /run
Start-Sleep 60
schtasks /TN User-PendingReboot-Afterwin11Upgrade /run