#!/bin/bash

# Configuración de red con Netplan
echo "Configurando la red..."
cat <<EOF | sudo tee /etc/netplan/00-installer-config.yaml
network:
  version: 2
  ethernets:
    enp0s3:
      dhcp4: no
      addresses:
        - 192.168.122.21/24
      routes:
        - to: default
          via: 192.168.122.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOF

# Aplicar la configuración de red
sudo netplan apply

# Instalación de BIND9
echo "Instalando BIND9..."
sudo apt update
sudo apt install -y bind9 bind9utils bind9-doc

# Configuración de zonas en BIND
echo "Configurando BIND9..."
cat <<EOF | sudo tee /etc/bind/named.conf.local
include "/etc/bind/zones.rfc1918";

zone "reprobados.com" {
    type master;
    file "/etc/bind/db.reprobados.com";
};

zone "122.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/db.192";
};
EOF

# Configuración de la zona directa
cat <<EOF | sudo tee /etc/bind/db.reprobados.com
\$TTL 604800
@   IN  SOA reprobados.com. admin.reprobados.com. (
        2024021701  ; Serial
        604800      ; Refresh
        86400       ; Retry
        2419200     ; Expire
        604800 )    ; Negative Cache TTL
;
@       IN  NS  ns1.reprobados.com.
ns1     IN  A   192.168.122.21
www     IN  A   192.168.122.10
mail    IN  A   192.168.122.11
ftp     IN  A   192.168.122.12
EOF

# Configuración de la zona inversa
cat <<EOF | sudo tee /etc/bind/db.192
\$TTL 604800
@   IN  SOA reprobados.com. admin.reprobados.com. (
        2024021701  ; Serial
        604800      ; Refresh
        86400       ; Retry
        2419200     ; Expire
        604800 )    ; Negative Cache TTL
;
@       IN  NS  ns1.reprobados.com.
21      IN  PTR ns1.reprobados.com.
10      IN  PTR www.reprobados.com.
11      IN  PTR mail.reprobados.com.
12      IN  PTR ftp.reprobados.com.
EOF

# Verificar la configuración de BIND9
echo "Verificando configuración de BIND9..."
sudo named-checkconf
sudo named-checkzone reprobados.com /etc/bind/db.reprobados.com
sudo named-checkzone 122.168.192.in-addr.arpa /etc/bind/db.192

# Reiniciar BIND9
echo "Reiniciando BIND9..."
sudo systemctl restart bind9
sudo systemctl enable bind9

# Mostrar el estado de BIND9
echo "Estado de BIND9:"
sudo systemctl status bind9 --no-pager

sudo named-checkconf