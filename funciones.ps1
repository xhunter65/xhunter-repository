Get-Verb

function get-fecha{
get-date
}

get-fecha

Get-ChildItem -Path function:\get-*

Get-ChildItem -Path Function:\get-fecha | Remove-Item

Get-ChildItem -Path function:\get-*

function Get-Resta {
    Param ([int] $num1, [int]$num2)

    $resta = $num1 - $num2
    Write-Host "La resta de los parametros es $resta"
}

Get-Resta 12 6

Get-Resta -num2 10 -num1 5
Get-Resta -num2 10

function Get-Resta {
    Param ([Parameter(Mandatory)] [int] $num1, [int]$num2)

    $resta = $num1 - $num2
    Write-Host "La resta de los parametros es $resta"
}

Get-Resta -num2 10

function Get-Resta {
    [CmdletBinding()]
    Param ([int]$num1, [int]$num2)
    $resta = $num1 - $num2
    Write-Host "La resta de los parametros es $resta"
}

(Get-Command -name Get-Resta).Parameters.Keys


function Get-Resta {
    [CmdletBinding()]
    Param ([int]$num1, [int]$num2)
    $resta = $num1 - $num2
    Write-Verbose -Message "Operacion que va a realizar una resta de $num1 y $num2"
    Write-Host "La resta de los parametros es $resta"

}

Get-Resta 10 5 -Verbose