@echo off

::Create a task to run weekly once
schtasks /Delete /tn "\System-PendingReboot-Afterwin11Upgrade" /f
schtasks /Delete /tn "\User-PendingReboot-Afterwin11Upgrade" /f

Del "C:\script\PendingReboot-Afterwin11Upgrade\Execute.bat" /Q
Del "C:\script\PendingReboot-Afterwin11Upgrade\System-PendingReboot-afterwin11Upgrade.ps1" /Q
Del "C:\script\PendingReboot-Afterwin11Upgrade\User-PendingReboot-afterwin11Upgrade.ps1" /Q
Del "C:\script\PendingReboot-Afterwin11Upgrade\UserExecute.bat" /Q
Del "C:\script\PendingReboot-Afterwin11Upgrade\PendingRebootYes.txt" /Q
Del "C:\script\PendingReboot-Afterwin11Upgrade\Rebootpendingyes.txt" /Q
del "C:\script\PendingReboot-Afterwin11Upgrade\Oneday.txt" /Q

