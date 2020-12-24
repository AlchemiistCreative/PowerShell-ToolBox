$Servicename = ''
$Serviceremote = Invoke-Command -ComputerName server.domain.local -ScriptBlock {Get-Service -Name '$Servicename*'}
$Servername = ''

if ($Serviceremote.Status -ne 'Running'){
    Send-MailMessage -To "mail@mail.com" -From "mail@mail.com"  -Subject "Service Name" -Body "Service is not running on $Servername" -SmtpServer "smtp.com" -Port 25
	
    }else {

    Send-MailMessage -To "mail@mail.com" -From "mail@mail.com"  -Subject "Service Name" -Body "Service is running on $Servername" -SmtpServer "smtp.com" -Port 25
	
    }
