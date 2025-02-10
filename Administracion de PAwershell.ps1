Get-Service


Get-Service -Name Spooler


Get-Service -DisplayName Hora*


Get-Service | Where-Object {$_.Status -eq "Running"}


Get-Service | Where-Object {$_.StartType -eq "Automatic"} | Select-Object Name, StartType


Get-Service -DependentServices Spooler


Get-Service -RequiredServices Fax



Stop-Service -Name Spooler -Confirm -PassThru


Start-Service -Name Spooler -Confirm -PassThru


Suspend-Service -Name stisvc -Confirm -PassThru


Get-Service | Where-Object CanPauseAndContinue -eq True


Suspend-Service -Name Spooler


Restart-Service -Name WSearch -Confirm -PassThru


Set-Service -Name dcsvc -DisplayName "Servicio de virtualización de credenciales de seguridad distribuidas"


Set-Service -Name BITS -StartupType Automatic -Confirm -PassThru | Select-Object Name, StartType


Set-Service -Name BITS -Description "Transfiere archivos en segundo plano mediante el uso de ancho de banda de red inactivo"


Get-CimInstance Win32_Service -Filter 'Name = "BITS"' | Format-List Name, Description


Set-Service -Name Spooler -Status Running -Confirm -PassThru


Set-Service -Name stisvc -Status Paused -Confirm -PassThru


Set-Service -Name BITS -Status Stopped -Confirm -PassThru 


Get-Process


Get-Process -Name Acrobat
Get-Process -Name Search*
Get-Process -id 13948

Get-Process WINWORD -FileVersionInfo
Get-Process WINWORD -IncludeUserName
Get-Process WINWORD -Module

Stop-Process -Name Acrobat -Confirm -PassThru

Stop-Process -id 10940 -Confirm -PassThru

Get-Process -Name Acrobat | Stop-Process -Confirm -PassThru

Start-Process -FilePath "C:\Windows\System32\Notepad.exe"

Start-Process -FilePath "cmd.exe" -ArgumentList "/c mkdir NuevaCarpeta" -WorkingDirectory "C:\Users\tutor\Desktop" -PassThru

Start-Process -FilePath "notepad.exe" -WindowStyle "Maximized" -PassThru

Start-Process -FilePath "C:\Users\tutor\Desktop\test.txt" -Verb print -PassThru

Get-Process -Name notep*
Wait-Process -Name notepad
Get-Process -name notep*

Get-Process -name notepad
Wait-Process -id 11568
Get-Process -Name notep*

Get-Process -name notep*
Get-Process -Name notepad | Wait-Process

Get-LocalUser

Get-LocalUser -Name Invitado | Select-Object *

Get-LocalUser -SID S-1-5-21-1356686170-1997479302-1560136649-501 | Select-Object *

Get-LocalGroup

Get-LocalGroup -Name administradores | Select-Object *

Get-LocalGroup -SID S-1-5-32-544 | Select-Object *

New-LocalUser -Name "Usuario" -Description "Usuario de Prueba 1" -NoPassword

New-LocalUser -Name "Usuario2" -Description "Usuario de Prueba 2" -Password (ConvertTo-SecureString -AsPlainText "12345" -Force) 

Get-LocalUser -Name "Usuario"
Remove-LocalUser -Name "Usuario"
Get-LocalUser -Name "Usuario"

Get-LocalUser -Name "Usuario2" | Remove-LocalUser
Get-LocalUser -Name "Usuario2"

New-LocalGroup -Name 'Grupo1' -Description 'Grupo de prueba 1'

Add-LocalGroupMember -Group Grupo1 -Member Usuario2 -Verbose

Get-LocalGroupMember Grupo1

Remove-LocalGroupMember -Group Grupo1 -Member Usuario
Remove-LocalGroupMember -Group Grupo1 -Member Usuario2
Get-LocalGroupMember Grupo1

Get-LocalGroup -Name "Grupo1"

Remove-LocalGroup -Name "Grupo1"
Get-LocalGroup -Name "Grupo1"
