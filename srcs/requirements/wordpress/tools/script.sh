#!/bin/bash

sleep 5

# Install WP-CLI if not present
if [ ! -f /usr/local/bin/wp ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
fi

# Download WordPress core if not already downloaded
if [ ! -f /var/www/html/wp-includes/version.php ]; then
    wp core download --allow-root --path=/var/www/html
fi

# Create wp-config.php if not present
if [ ! -f /var/www/html/wp-config.php ]; then
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
fi

# Configure database connection
wp config set DB_NAME "$SQL_DATABASE" --allow-root --path=/var/www/html
wp config set DB_USER "$SQL_USER" --allow-root --path=/var/www/html
wp config set DB_PASSWORD "$SQL_PASSWORD" --allow-root --path=/var/www/html
wp config set DB_HOST 'mariadb:3306' --allow-root --path=/var/www/html

# Install WordPress if not already installed
if ! wp core is-installed --allow-root --path=/var/www/html 2>/dev/null; then
    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Cloud-1" \
        --admin_user="$ADMIN_USER" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_EMAIL" \
        --allow-root \
        --path=/var/www/html

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root \
        --path=/var/www/html
fi

mkdir -p /run/php/
/usr/sbin/php-fpm8.2 -F
