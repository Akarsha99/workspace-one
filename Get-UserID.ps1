$UserName = "CORP\"+(Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\CloudDomainJoin\JoinInfo\*"|select -ExpandProperty Useremail).split('@')[0]
$objUser = New-Object System.Security.Principal.NTAccount("$UserName")
$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
$accountName = $strSID.Value

if($accountName ){$accountName = $strSID.Value}else{$accountName = $null}
return $accountName