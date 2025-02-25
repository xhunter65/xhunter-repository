$IP = Read-Host "Ingrese su ip deseada (Ejemplo 10.0.0.2)"
$GWay = Read-Host "Ingrese su gateway deseada (Ejemplo 10.0.0.1)"
$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1
$interfaceIndex = $adapter.ifIndex
$ipDetails = Get-NetIPAddress -InterfaceIndex $interfaceIndex | Where-Object { $_.AddressFamily -eq "IPv4" }
Write-Host $currentIP
$subnetMask = $ipDetails.PrefixLength
Set-NetIPInterface -InterfaceIndex $interfaceIndex -Dhcp Disabled
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress $ip -PrefixLength 24 -DefaultGateway $GWay
