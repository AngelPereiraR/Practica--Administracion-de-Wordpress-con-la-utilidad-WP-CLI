#!/bin/bash

# Cargar variables de entorno del archivo .env
export $(grep -v '^#' .env | xargs)

# Actualizar repositorios
sudo apt update -y

# Instalar Apache
sudo apt install apache2 -y

# Habilitar Apache para que inicie automáticamente
sudo systemctl enable apache2
sudo systemctl start apache2

# Instalar MySQL
sudo apt install mysql-server -y
sudo mysql_secure_installation <<EOF

y
$APP_PASSWORD
$APP_PASSWORD
y
y
y
y
EOF

# Instalar PHP
sudo apt install php libapache2-mod-php php-mysql -y

# Reiniciar Apache para cargar PHP
sudo systemctl restart apache2
