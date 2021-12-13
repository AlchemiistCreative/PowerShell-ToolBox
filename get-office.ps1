param(
[string]$user,
[string]$complist
)


$computers = (Get-Content $complist) 


$cred = Get-Credential -Credential $user 

foreach ($computer in $computers){
Invoke-Command -ComputerName $computer -Credential $cred -ScriptBlock { 

$installed = (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where { $_.DisplayName -eq "*Office*" }) -ne $null

} 


 If(-Not $installed) {
    Write-Host "Office is NOT installed on $computer"
} else {
    Write-Host $installed.DisplayName "is installed on $computer"
}
}