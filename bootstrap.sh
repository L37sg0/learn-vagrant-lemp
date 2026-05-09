#!/usr/bin/env bash
set -e

# Non-interactive
export DEBIAN_FRONTEND=noninteractive

# 1. Install services
apt-get update
apt-get install -y nginx mysql-server unzip \
    php8.1-fpm php8.1-cli php8.1-common php8.1-mysql \
    php8.1-zip php8.1-gd php8.1-mbstring php8.1-curl \
    php8.1-xml php8.1-bcmath

# 2. Symlinc
# sites-available to sites-enabled for example.conf
rm -f /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default 
ln -sf /etc/nginx/sites-available/99-example.conf /etc/nginx/sites-enabled/
rm -f /var/www/html/index.nginx-debian.html
# php and mysql custom configurations
ln -sf /etc/php/8.1/fpm/conf.d/custom/99-local.ini /etc/php/8.1/fpm/conf.d/99-local.ini
ln -sf /etc/mysql/conf.d/custom/99-my.cnf /etc/mysql/conf.d/99-my.cnf



# 3. Set up mysql for php
# Create new user with password for php to use mysql
mysql -e "CREATE USER IF NOT EXISTS 'dbuser'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'dbuser'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES;"

# 4. Restart services and apply changes
systemctl restart php8.1-fpm
systemctl restart mysql
systemctl restart nginx

# 5. Install Composer
if [ ! -f /usr/local/bin/composer ]; then
    curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
fi
mkdir -p /home/vagrant/.composer
chown -R vagrant:vagrant /home/vagrant/.composer
composer --version