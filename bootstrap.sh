#!/usr/bin/env bash
set -e

# Install requred software
apt-get install -y software-properties-common
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get install -y apt-transport-https ca-certificates
apt-get install -y nginx mysql-server
apt-get install -y --no-install-recommends php8.1
apt-get install -y php8.1-fpm php8.1-cli php8.1-common php8.1-mysql php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl php8.1-xml php8.1-bcmath unzip

# Enable services
systemctl start php8.1-fpm
systemctl enable php8.1-fpm
systemctl start mysql.service

# Configure nginx for php
cat << "EOF" > /etc/nginx/sites-available/example.conf
server {
    listen 80;
    root /var/www/html;
    index index.php index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

# Activate example website and restart nginx
ln -sf /etc/nginx/sites-available/example.conf /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default
systemctl restart nginx