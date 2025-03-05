#!/bin/bash

echo "Configuración de IP en Ubuntu Server"

# Pedir datos al usuario
read -p "Ingrese el nombre de su interfaz de red (Ejemplo: eth0): " inf
read -p "Ingrese su IP estática con prefijo CIDR (Ejemplo: 192.168.1.2/24): " ip
read -p "Ingrese la puerta de enlace (Gateway) (Ejemplo: 192.168.1.1): " gWay
read -p "Ingrese los servidores DNS separados por comas (Ejemplo: 8.8.8.8,8.8.4.4): " dns

# Validar que la IP tenga el prefijo CIDR
if [[ ! "$ip" =~ /[0-9]+$ ]]; then
    echo "❌ Error: La IP debe incluir el prefijo CIDR (Ejemplo: 192.168.1.2/24)"
    exit 1
fi

# Crear archivo de configuración de Netplan con permisos adecuados
sudo bash -c "cat > /etc/netplan/00-installer-config.yaml <<EOL
network:
  version: 2
  renderer: networkd
  ethernets:
    $inf:
      dhcp4: no
      addresses:
        - $ip
      gateway4: $gWay
      nameservers:
        addresses: [$dns]
EOL"

# Ajustar permisos del archivo
sudo chmod 600 /etc/netplan/00-installer-config.yaml

# Aplicar cambios
echo "Aplicando nueva configuración de red..."
sudo netplan apply

echo "✅ Configuración de IP estática aplicada correctamente."
