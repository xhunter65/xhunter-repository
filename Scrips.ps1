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
