#!/bin/bash

# Configuración de variables desde el archivo .env
source "$(dirname "$0")/.env"

# Comprobación de privilegios de superusuario
if [ "$EUID" -ne 0 ]; then
  echo "Este script debe ejecutarse como root." >&2
  exit 1
fi

# Instalación de Certbot y plugins de Apache
echo "Instalando Certbot y los plugins necesarios..."
apt update
apt install -y certbot python3-certbot-apache

# Solicitud del certificado SSL/TLS
echo "Solicitando un certificado SSL/TLS para el dominio $DOMAIN..."
certbot --apache --non-interactive --agree-tos --email "$EMAIL" -d "$DOMAIN"

# Configuración de renovación automática
echo "Configurando la renovación automática del certificado..."
echo "0 3 * * * root certbot renew --quiet" > /etc/cron.d/certbot-renew

echo "Configuración de HTTPS completada correctamente."
