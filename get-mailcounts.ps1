param(
[string]$range="day",
[string]$recipient="mail@example.com"
)

$day = (Get-Date).AddHours(-24)
$week = (Get-Date).AddDays(-7)
$month = (Get-Date).AddDays(-30)

switch ($range)
{
    "day" {$msg = Get-TransportService | Get-MessageTrackingLog -Start $day -Recipients $recipient -ResultSize unlimited}
    "week" {$msg = Get-TransportService | Get-MessageTrackingLog -Start $week -Recipients $recipient -ResultSize unlimited}
    "month" {$msg = Get-TransportService | Get-MessageTrackingLog -Start $month -Recipients $recipient -ResultSize unlimited }
}

Write-Host $msg.count
