#!/bin/bash

# Solicitar datos al usuario
read -p "Ingrese la subred (ejemplo, 192.168.1.0): " subred
read -p "Ingrese la máscara de subred (ejemplo, 255.255.255.0): " mascara
read -p "Ingrese el rango de direcciones IP (inicio, ejemplo, 192.168.1.100): " rango_inicio
read -p "Ingrese el rango de direcciones IP (fin, ejemplo, 192.168.1.200): " rango_fin
read -p "Ingrese la dirección IP del router: " router
read -p "Ingrese las direcciones IP de los servidores DNS (ejemplo, 8.8.8.8,8.8.4.4): " dns
read -p "Ingrese la dirección IP estática deseada para este servidor: " ip_estatica

# Actualizar el sistema
sudo apt-get update -y
sudo apt-get upgrade -y

# Instalar el servidor DHCP
sudo apt install isc-dhcp-server -y

# Configurar el archivo dhcpd.conf
sudo bash -c "cat > /etc/dhcp/dhcpd.conf <<EOF
default-lease-time 600;
max-lease-time 7200;
authoritative;

subnet $subred netmask $mascara {
    range $rango_inicio $rango_fin;
    option routers $router;
    option subnet-mask $mascara;
    option domain-name-servers $dns;
}
EOF"

# Detectar la interfaz de red automáticamente
INTERFAZ=$(ip -o -4 addr list | grep -v '127.0.0.1' | awk '{print $2}' | head -1)

# Configurar la IP estática con Netplan
sudo bash -c "cat > /etc/netplan/01-static-ip.yaml <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFAZ:
      dhcp4: no
      addresses: [$ip_estatica/24]
      gateway4: $router
      nameservers:
        addresses: [${dns//,/, }]
EOF"

# Aplicar la configuración de Netplan
sudo netplan apply

# Configurar la interfaz de red para el DHCP
sudo sed -i "s/^INTERFACESv4=\".*\"/INTERFACESv4=\"$INTERFAZ\"/" /etc/default/isc-dhcp-server

# Asegurarse de que el archivo de leases existe
sudo touch /var/lib/dhcp/dhcpd.leases
sudo chmod 644 /var/lib/dhcp/dhcpd.leases
sudo chown dhcpd:dhcpd /var/lib/dhcp/dhcpd.leases

# Reiniciar y habilitar el servicio DHCP
sudo systemctl restart isc-dhcp-server
sudo systemctl enable isc-dhcp-server

# Verificar si el servicio está activo
if sudo systemctl is-active --quiet isc-dhcp-server; then
    echo "✅ Servidor DHCP configurado y ejecutando correctamente en la interfaz $INTERFAZ."
else
    echo "❌ Error: El servidor DHCP no se inició correctamente. Verifique la configuración con: sudo systemctl status isc-dhcp-server"
fi

