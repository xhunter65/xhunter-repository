Get-Command -type Cmdlet | Sort-Object -Property Noun | Format-Table -GroupBy Noun 


Get-Command -Name Get-ChildItem -Args Cert: -Syntax

Get-Command -Name dir

Get-Command -Noun WSManInstance

Get-Service -name "LSM" | Get-Member 

Get-Service -name "LSM" | Get-Member -MemberType Property

Get-Item '.\Nuevo Documento de texto.txt' | Get-Member -MemberType Method

Get-Item '.\Nuevo Documento de texto.txt' | Select-Object Name, Length

Get-Service | Select-Object -Last 5

Get-Service | Select-Object -First 5

Get-Service | Where-Object {$_.Status -eq "Running"}

(Get-Item '.\Nuevo Documento de texto.txt').IsReadOnly

(Get-Item '.\Nuevo Documento de texto.txt').IsReadOnly = 1

(Get-Item '.\Nuevo Documento de texto.txt').IsReadOnly = 0

