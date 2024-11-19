#!/bin/bash

# Cargar variables de entorno del archivo .env
export $(grep -v '^#' .env | xargs)

# Instalar phpMyAdmin
sudo apt install phpmyadmin -y
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

# Configurar contraseña de phpMyAdmin
sudo mysql -u root <<EOF
CREATE USER 'phpmyadmin'@'localhost' IDENTIFIED BY '$PHPMYADMIN_APP_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO 'phpmyadmin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Instalar Adminer
sudo mkdir -p /var/www/html/adminer
cd /var/www/html/adminer
sudo wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php
sudo mv adminer-4.8.1.php index.php

# Instalar GoAccess para analizar logs de Apache
sudo apt install goaccess -y

# Crear archivo de configuración para GoAccess (opcional)
echo "GoAccess instalado y configurado."
