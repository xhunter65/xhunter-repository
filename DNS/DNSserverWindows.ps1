Install-WindowsFeature -Name DNS

Install-WindowsFeature -Name DNS -IncludeManagementTools

Get-WindowsOptionalFeature -Online | Where Name -Match "RSAT.*" | Format-Table -Autosize

Add-WindowsCapability -Online -Name Rsat.Dns.Tools

$adapter = Get-NetAdapter | Where-Object { $_.Status -eq "Up" } | Select-Object -First 1

$interfaceIndex = $adapter.ifIndex

$ipDetails = Get-NetIPAddress -InterfaceIndex $interfaceIndex | Where-Object { $_.AddressFamily -eq "IPv4" }

$currentIP = "192.168.122.21"

Write-Host $currentIP

$subnetMask = $ipDetails.PrefixLength

$gateway = "192.168.122.0"

Set-NetIPInterface -InterfaceIndex $interfaceIndex -Dhcp Disabled

New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress $currentIP -PrefixLength 24 -DefaultGateway $gateway

Set-NetFirewallProfile -Enabled False

Add-DnsServerPrimaryZone -Name "reprobados.com" -ZoneFile "reprobados.com.dns" -DynamicUpdate None -PassThru

Add-DnsServerResourceRecordA -Name "www" -ZoneName "reprobados.com" -IPv4Address $currentIP -TimeToLive 01:00:00 -PassThru

Add-DnsServerResourceRecordA -Name "@" -ZoneName "reprobados.com" -IPv4Address $currentIP -TimeToLive 01:00:00 -PassThru


