#!/bin/bash

echo "🔹 Instalando OpenSSH Server..."

# Actualizar repositorios e instalar OpenSSH si no está instalado
if ! dpkg -l | grep -q openssh-server; then
    apt update && apt install -y openssh-server
    echo "✅ OpenSSH instalado correctamente."
else
    echo "ℹ️ OpenSSH ya está instalado."
fi

# Habilitar e iniciar SSH
echo "🔹 Habilitando y arrancando SSH..."
systemctl enable ssh
systemctl start ssh

# Configurar Firewall para permitir SSH si UFW está instalado
if command -v ufw &> /dev/null; then
    echo "🔹 Configurando el firewall..."
    ufw allow 22/tcp
else
    echo "⚠️ UFW no está instalado, se omite la configuración del firewall."
fi

# Reiniciar SSH para aplicar cambios
echo "🔹 Reiniciando SSH para aplicar cambios..."
systemctl restart ssh

# Mostrar estado final del servicio
echo "🔹 Verificando estado de SSH..."
systemctl is-active --quiet ssh && echo "✅ SSH está en ejecución." || echo "❌ Error: SSH no se inició correctamente."

# Mostrar la dirección IP del servidor
echo "🔹 Dirección IP del servidor:"
hostname -I | awk '{print "➡️  " $1}'

echo "✅ SSH está configurado y en ejecución."
echo "ℹ️ Ahora puedes conectarte con: ssh usuario@$(hostname -I | awk '{print $1}')"
