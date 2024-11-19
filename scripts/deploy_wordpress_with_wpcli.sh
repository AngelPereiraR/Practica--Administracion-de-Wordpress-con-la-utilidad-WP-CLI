#!/bin/bash

# Configuración de variables desde el archivo .env
source "$(dirname "$0")/.env"

# Comprobación de privilegios de superusuario
if [ "$EUID" -ne 0 ]; then
  echo "Este script debe ejecutarse como root." >&2
  exit 1
fi

# Instalación de WP-CLI
echo "Instalando WP-CLI..."
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Descarga e instalación de WordPress
echo "Descargando e instalando WordPress..."
wp core download --path=/var/www/html --allow-root

# Configuración del archivo wp-config.php
echo "Configurando wp-config.php..."
wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASS" --dbhost="$DB_HOST" --path=/var/www/html --allow-root

# Instalación de la base de datos
echo "Instalando la base de datos de WordPress..."
wp db create --path=/var/www/html --allow-root
wp core install --url="$SITE_URL" --title="$SITE_TITLE" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="$ADMIN_EMAIL" --path=/var/www/html --allow-root

# Configuración de permisos
echo "Configurando permisos de los archivos de WordPress..."
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

echo "WordPress ha sido instalado y configurado exitosamente."
