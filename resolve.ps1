param(
[string]$type='text',
[string]$srv='8.8.8.8'

)

$FinalResult = @()

$ExportPath = Read-Host "Name of the file"


Function Get-FileName($initialDirectory)
{
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$OpenFileDialog.InitialDirectory = $initialDirectory
$OpenFileDialog.Filter = "(*.txt) | *.*"
$OpenFileDialog.ShowDialog() | Out-Null
$OpenFileDialog.FileName

}
$inputfile = Get-FileName ("C:\temp")

$list = Get-Content $inputfile
$i = 0
ForEach ($Item in $list)
{ 
$tempObj = "" | Select-Object Name,IPAddress,Status,ErrorMessage
$i += 1
try {
 $dnsRecord = Resolve-DnsName $Item -Server $srv -ErrorAction Stop | Where-Object {$_.Type -eq 'A'} 
 $tempObj.Name = $Item
 $tempObj.IPAddress = ($dnsRecord.IPAddress -join ',')
 $tempObj.Status = 'OK'
 $tempObj.ErrorMessage = ''
}
catch {
$tempObj.Name = $Item
$tempObj.IPAddress = ''
$tempObj.Status = 'NOT_OK'
$tempObj.ErrorMessage = $_.Exception.Message
}

$FinalResult += $tempObj


} 

if ($type -eq 'text'){
$FinalResult | Out-File -FilePath "./$ExportPath.txt"

}else{

$FinalResult | Export-Csv -Path "./$ExportPath.csv" -NoTypeInformation -Delimiter ';'

}

Write-Host -ForegroundColor DarkGreen "File is created"
Write-Host -ForegroundColor DarkGreen "$i domains resolved with this server: $srv"