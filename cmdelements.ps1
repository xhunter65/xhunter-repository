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


Get-ChildItem *.txt
(Get-Item '.\Nuevo Documento de texto.txt')

(Get-Item '.\Nuevo Documento de texto.txt'). CopyTo("D:\Desktop\prueba.txt")

(Get-Item .\test.txt).Delete()

Get-ChildItem *.txt

$miObjeto = New-Object PSObject

$miObjeto | Add-Member -MemberType NoteProperty -Name Nombre -Value "Miguel"

 $miObjeto | Add-Member -MemberType NoteProperty -Name Edad -Value 23

 $miObjeto | Add-Member -MemberType ScriptMethod -Name Saludar -Value { Write-Host "¡Hola Mundo!" }

 $miObjeto | Get-Member

 $miObjeto = New-Object -TypeName PSObject -Property 
 @{
>>    Nombre = "Miguel"
>>    Edad = 23
>> }

$miObjeto | Add-Member -MemberType ScriptMethod -Name Saludar -Value { Write-Host "¡Hola Mundo!" }
$miObjeto | Get-Member

$miObjeto = [PSCustomObject]@{
>>    Nombre = "Miguel"
>>    Edad = 23
>> }

$miObjeto | Add-Member -MemberType ScriptMethod -Name Saludar -Value { Write-Host "¡Hola Mundo!" }

miObjeto | Get-Member

Get-Process -Name Acrobat  | Stop-Process

Get-help -full Get-Process

Get-help -full Stop-Process

Get-Command -Name dir

Get-Command -Noun WSManInstance

