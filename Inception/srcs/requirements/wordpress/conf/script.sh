#!/bin/bash

# Create necessary directories for WordPress installation
mkdir /var/www/
mkdir /var/www/html

# /var/www/ is typically the default location where web server software like Apache or Nginx serves website content from.

cd /var/www/html

# remove existing files from volume if there are any to install it again
rm -rf /var/www/html/*

# Download WP-CLI for managing WordPress installations
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

chmod +x wp-cli.phar 

# Move WP-CLI to the bin directory for global access, in order to use `wp` instead of `php wp-cli.phar`
mv wp-cli.phar /usr/local/bin/wp

# Download the WordPress core files
wp core download --allow-root

# Rename the sample configuration file and replace placeholders with actual database credentials, to connect with our database
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PWD/" wp-config.php
sed -i "s/localhost/$DB_HOST/" wp-config.php

# /wait-for-it.sh $DB_HOST:3306 --timeout=0 --strict -- 

# Install WordPress with provided settings
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# Explicitly update the site title
#wp option update blogname "$WP_TITLE" --allow-root
# Create a new user with author role
wp user create $WP_USR_NAME $WP_USR_EMAIL --role=author --user_pass=$WP_USR_PWD --allow-root

# Install and activate the Astra theme
wp theme install twentytwentyone --activate --allow-root

# Update PHP-FPM configuration to listen on port 9000
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Create directory for PHP socket file
mkdir /run/php

# Start PHP-FPM service in the foreground
php-fpm7.4 -F