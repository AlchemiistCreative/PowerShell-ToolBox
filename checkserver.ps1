$Date = (Get-Date).AddDays(-7)
$servers = get-content servers.txt
$cred=Get-Credential
$week= Get-Date -UFormat %V
foreach ($server in $servers)
{
    $out += Get-WinEvent -ComputerName $server -FilterHashtable @{ LogName='Application','System'; StartTime=$Date; Level=1,2,3 } -Credential $cred | Select-Object Message,Id,Level,ProviderName,LogName,MachineName | Sort-Object ProviderName, ID  -unique
  
}

$out | Export-Csv -Path "check-week-$week.csv" -NoTypeInformation -Delimiter ';'


Send-MailMessage -From 'mail@mail.com' -To 'mail@mail.com' -Subject 'Check server week $week' -Body "Check server week $week" -Attachments .\check-week-$week.csv -Priority High -DeliveryNotificationOption OnSuccess, OnFailure -SmtpServer 'your-smtp-server.com'