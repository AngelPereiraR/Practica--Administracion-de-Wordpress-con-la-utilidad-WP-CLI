# Proyecto de Automatización: Instalación de WordPress con WP-CLI

Este repositorio contiene los scripts y configuraciones necesarias para automatizar la instalación de WordPress utilizando WP-CLI, junto con la pila LAMP y configuración HTTPS con Let’s Encrypt.

## Estructura del repositorio

```plaintext
.
├── README.md
├── conf
│   └── 000-default.conf
├── htaccess
│   └── .htaccess
└── scripts
    ├── .env
    ├── install_lamp.sh
    ├── setup_letsencrypt_https.sh
    └── deploy_wordpress_with_wpcli.sh
```

## Pasos de instalación y configuración

### 1. Instalación de la pila LAMP

El script install_lamp.sh automatiza la instalación de Apache, MySQL y PHP en un servidor Ubuntu Server. Configura también módulos básicos y crea una base de datos.

### 2. Configuración HTTPS

El script setup_letsencrypt_https.sh solicita un certificado SSL/TLS de Let’s Encrypt para el dominio configurado y habilita HTTPS en el servidor Apache.

### 3. Instalación y despliegue de WordPress

El script deploy_wordpress_with_wpcli.sh utiliza la herramienta WP-CLI para automatizar:

- La descarga de WordPress.
- La creación y configuración del archivo wp-config.php.
- La configuración inicial del sitio web.

### 4. Variables de configuración

El archivo .env debe incluir las siguientes variables:

```env
DOMAIN=example.com
EMAIL=admin@example.com
DB_NAME=wordpress_db
DB_USER=wordpress_user
DB_PASS=secure_password
DB_HOST=localhost
SITE_URL=https://example.com
SITE_TITLE="Mi Sitio WordPress"
ADMIN_USER=admin
ADMIN_PASS=admin_password
ADMIN_EMAIL=admin@example.com
```

## Requisitos previos

- Ubuntu Server actualizado.
- Usuario con privilegios de superusuario.
- Configuración de DNS apuntando al servidor.
