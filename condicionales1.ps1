$condicion = $fallse
if ( $condicion )
{
	Write-Output "La condicion era verdadera"
}
else
{
	Write-Output "La condicion era falsa"
}



$numero = 2
if ($numero -ge 3 )
{
    write-output "el numero [$numero] es mayor o igual que 3"
}
elseif ( $numero -lt 2)
{
	Write-Output "El numero [$numero] es menor que 2"
}
else
{
	Write-Output "El numero [$numero] es igual a 2"
}
$PSVersionTable

$mensaje (Test-Path $path) ? "Path existe" : "Path no encontrado"
$mensaje

switch (3)
{
	1{"[$_] es uno."}
	2{"[$_] es dos."}
	3{"[$_] es tres."}
	4{"[$_] es cuatro."}
}

switch (3)
{
	1{"[$_] es uno."}
	2{"[$_] es dos."}
	3{"[$_] es tres."}
	4{"[$_] es cuatro."}
	3{"[$_] es tres de nuevo."}
}

switch (2, 5)
{
	1{"[$_] es uno."}
	2{"[$_] es dos."}
	3{"[$_] es tres."}
	4{"[$_] es cuatro."}
	5{"[$_] es cinco."}
}

switch ("seis")
{
	1{"[$_] es uno."; Break}
	2{"[$_] es dos."; Break}
	3{"[$_] es tres."; Break}
	4{"[$_] es cuatro."; Break}
	5{"[$_] es cinco."; Break}
	"se*" {"[$_] coincide con se*."}
	Default {
		"No hay coincidencias con [$_]"
		}
}

switch -Wildcard ("seis")
{
	1{"[$_] es uno."; Break}
	2{"[$_] es dos."; Break}
	3{"[$_] es tres."; Break}
	4{"[$_] es cuatro."; Break}
	5{"[$_] es cinco."; Break}
	"se*" {"[$_] coincide con se*."}
	Default {
		"No hay coincidencias con [$_]"
		}
}

$email = 'antonio.yanez@udc.es'
$email2 = 'antonio.yanez@udc.gal'
$url = 'https://www.dc.fi.udc.es/~afyanez/Docencia/2023'
switch -Regex ($url, $email, $email2)
{
	'^\w+\.\w+@(udc|usc|edu)\.es|gal$' { "[$_] es una direccion de correo electronico academica"}
	'^ftp\://.*$' { "[$_] es una direccion ftp" }
	'^(http[s]?)\://.*$' { "[$_] es una direccion web, que utiliza [$($matches[1])]"}
}


for (($i = 0), ($j = 0); $i -lt 5; $i++)
{
	"`$i:$i"
	"`$j:$j"
}

for ($($i = 0;$j = 0); $i -lt 5; $($i++;$j++))
{
	"`$i:$i"
	"`$j:$j"
}

$ssoo = "freebsd", "openbsd", "solaris", "fedora", "ubuntu", "netbsd"
foreach ($so in $ssoo)
{
	Write-Host $so
}

foreach ($archivo in Get-ChildItem)
{
	if ($archivo.length -ge 10KB)
	{
		Write-Host $archivo -> [($archivo.length)]
	}
}

$num = 0

while ($num -ne 3)
{
	$num++
	Write-Host $num
}

$num = 0

while ($num -ne 5)
{
	if ($num -eq 1) { $num = $num + 3 ; Continue}
	$num++
	Write-Host $num
}

$valor = 5
$multiplicacion = 1
do
{
	$multiplicacion = $multiplicacion * $valor
	$valor--
}
while ($valor -gt 0)

Write-Host $multiplicacion

$num = 10

for($i = 2; $i -lt 10; $i++)
{
    $num = $num+$i
    if ($1 -eq 5) { Break }

}
Write-Host $num
Write-host $i

$cadena = "Hola, buenas tardes"
$cadena2 = "Hola, buenas noches"

switch -Wildcard ($cadena, $cadena2)
{
    "Hola, buenas*" { "[$_] coincide con [Hola, buenas*]" }
    "Hola, bue*" { "[$_] coincide con [Hola, bue*]" }
    "Hola,*" { "[$_] coincide con [Hola,*]"; Break }
    "Hola, buenas tardes" { "[$_] coincide con [Hola, buenas tardes]" }
}

$num = 10

for($i = 2; $i -lt 10; $i++)
{
    
    if ($1 -eq 5) { Continue }
    $num = $num+$i
}
Write-Host $num
Write-host $i

$cadena = "Hola, buenas tardes"
$cadena2 = "Hola, buenas noches"

switch -Wildcard ($cadena, $cadena2)
{
    "Hola, buenas*" { "[$_] coincide con [Hola, buenas*]" }
    "Hola, bue*" { "[$_] coincide con [Hola, bue*]"; Continue }
    "Hola,*" { "[$_] coincide con [Hola,*]" }
    "Hola, buenas tardes" { "[$_] coincide con [Hola, buenas tardes]" }
}
