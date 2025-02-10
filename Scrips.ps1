try {
    Write-Output "Todo bien"
}
catch {
    Write-Output "Algo lanzo una excepcion"
    Write-Output $_
}
try {
    Start-Something -ErrorAction Stop
}
catch {
    Write-Output "Algo genero una excepcion o uso Write-Error"
    Write-Output $_
}

$comando = [System.Data.SqlClient.SqlCommand]::New($queryString, $connection)

try {
    $comando.Connection.Open()
    $comando.ExecuteNonQuery()
}
finally {
    Write-Error "Ha habido un problema con la ejecución de la query. Cerrando la conexión"
    $comando.Connection.Close()
}

try {
    Start-Something -Path $path -ErrorAction Stop
}
catch [System.IO.DirectoryNotFoundException], [System.IO.FileNotFoundException] {
    Write-Output "El directorio o fichero no ha sido encontrado: [$path]"
}
catch [System.IO.IOException] {
    Write-Output "Error de IO con el archivo: [$path]"
}



throw "No se puede encontrar la ruta: $path"

throw [System.IO.FileNotFoundException] "No se puede encontrar la ruta: $path"

throw [System.IO.FileNotFoundException]::new()

throw [System.IO.FileNotFoundException]::new("No se puede encontrar la ruta: $path")

throw (New-Object -TypeName System.IO.FileNotFoundException)

throw (New-Object -TypeName System.IO.FileNotFoundException -ArgumentList "No se puede encontrar la ruta: $path")



try {
    Write-Output $PSItem.ToString()
}
catch {
    Write-Output "Error capturado: $_"
}

throw [System.Exception]::new('primero')
throw [System.Exception]::new('segundo')
throw [System.Exception]::new('tercero')

function Backup-Registry {
    Param(
        [Parameter(Mandatory = $true)]
        [string]$rutaBackup
    )

    # Crear la ruta de destino del backup si no existe
    if (!(Test-Path -Path $rutaBackup)) {
        New-Item -ItemType Directory -Path $rutaBackup -Force | Out-Null
    }

    # Generar un nombre único para el archivo de backup
    $nombreArchivo = "Backup-Registry_" + (Get-Date -Format "yyyy-MM-dd_HH-mm-ss") + ".reg"
    $rutaArchivo = Join-Path -Path $rutaBackup -ChildPath $nombreArchivo

    # Realizar el backup del registro del sistema y guardarlo en el archivo de destino
    try {
        Write-Verbose "Realizando backup del registro del sistema en $rutaArchivo..."
        reg export HKLM "$rutaArchivo"
        Write-Verbose "El backup del registro del sistema se ha realizado con éxito en $rutaArchivo."
    }
    catch {
        Write-Error "Se ha producido un error al realizar el backup del registro del sistema: $_"
        return $false  # Indicar que el backup falló
    }

    return $true  # Indicar que el backup fue exitoso
}


# Escribir en el archivo de log
$logDirectory = "$env:APPDATA\RegistryBackup"
$logFile = Join-Path $logDirectory "backup-registry_log.txt"
$logEntry = "$(Get-Date) - $env:USERNAME - Backup - $backupPath"

if (!(Test-Path $logDirectory)) {
    New-Item -ItemType Directory -Path $logDirectory | Out-Null
}

Add-Content -Path $logFile -Value $logEntry


# Verificar si hay más de $backupCount backups en el directorio y
# eliminar los más antiguos si es necesario
$backupCount = 10
$backups = Get-ChildItem $backupDirectory -Filter "*.reg" | Sort-Object LastWriteTime -Descending

if ($backups.Count -gt $backupCount) {
    $backupsToDelete = $backups[$backupCount..($backups.Count - 1)]
    $backupsToDelete | Remove-Item -Force
}

@{
    ModuleVersion = '1.0.0'
    PowerShellVersion = '5.1'
    RootModule = 'Backup-Registry.ps1'
    Description = 'Módulo para realizar backups del registro del sistema de Windows'
    Author = 'Alice'
    FunctionsToExport = @('Backup-Registry')
}

ls

Import-Module BackupRegistry

Get-Help Backup-Registry

Backup-Registry -rutaBackup 'C:\tmp\Backups\Registro\'

vim .\Backup-Registry.ps1
Import-Module BackupRegistry -Force
Backup-Registry -rutaBackup 'C:\tmp\Backups\Registro\'

ls 'C:\tmp\Backups\Registro\'

# Configuración de la tarea
$Time = New-ScheduledTaskTrigger -At 02:00 -Daily

# Acción de la tarea
$PS = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument "-Command `"Import-Module BackupRegistry -Force; Backup-Registry -rutaBackup 'D:\tmp\Backups\Registro' `""

# Crear la tarea programada
Register-ScheduledTask -TaskName "Ejecutar Backup del Registro del Sistema" -Trigger $Time -Action $PS

ls 'C:\tmp\Backups\Registro\'
Get-date

ls 'C:\tmp\Backups\Registro\'
Get-Date

Get-ScheduledTask

Unregister-ScheduledTask ‘Ejecutar Backup del Registro 
del Sistema’
Get-ScheduledTask



