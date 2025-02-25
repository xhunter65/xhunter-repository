./StaticIPWinServer.ps1
$IPName = Read-Host "Nombre para la scope (Ejemplo 10.0.0.0)"
$IPStart = Read-Host "Ingrese el inicio del rango (Ejemplo 10.0.0.10)"
$IPEnd = Read-Host "Ingrese las final de su rango (Ejemplo 10.0.0.100)"
$SBNET = Read-Host "Ingrese su mascara de subneteo (Ejemplo 255.255.255.0)"
Install-WindowsFeature -Name DHCP -IncludeManagementTools
Add-DhcpServerv4Scope -Name $IPName -StartRange $IPStart -EndRange $IPEnd -SubnetMask $SBNET
