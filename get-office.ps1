#### Require AD Module / RSAT ####

function get-office($computername) {
    
    Write-Host "Installed version: "
    Get-WmiObject win32_product -ComputerName $computername | where {$_.Name -like "Microsoft Office Professional Plus*" -or $_.Name -Like "Microsoft Office Standard*" -or $_.Name -Like "Microsoft 365*"}  | Select-Object Name,Version


}



function get-computers{


$computers_ = Get-ADComputer -Filter * 
$computers__ = $computers_.Name
foreach($c in $computers__){



if(Test-WSMAN $c  -ErrorAction SilentlyContinue ){
    Write-Host "$c in reachable"
    
    get-office $c

}else{
    
    Write-Host "$c is unreachable"
}

}


}


get-computers

