# Source: https://www.tecmint.com/install-wordpress-on-ubuntu-16-04-with-lamp/
# This script will create new wordpress site using the existing template.

# test php
# sudo nano /var/www/html/info.php
#    <?php  phpinfo();  ?>

sudo cd /opt

# Install wordpress cms
sudo wget -c http://wordpress.org/latest.tar.gz
sudo tar -xzvf latest.tar.gz

# Move to /var/www/html
sudo rsync -av wordpress/* /var/www/html/

# set permission
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Wordpress database
mysql -u root -p   (password root)
# Enter the following commands,
#   mysql> CREATE DATABASE wp_myblog;
#   mysql> GRANT ALL PRIVILEGES ON wp_myblog.* TO 'vagrant'@'127.0.0.1' IDENTIFIED BY 'vagrant';
#   mysql> FLUSH PRIVILEGES;
#   mysql> EXIT;

# Rename directory
sudo mv wp-config-sample.php wp-config.php
sudo cp wp-config.php wp-config-sample.php

# Add modify the following
#   // ** MySQL settings - You can get this info from your web host ** //
#   /** The name of the database for WordPress */ define('DB_NAME', 'wp_myblog'); 
#   /** MySQL database username */ define('DB_USER', 'vagrant'); 
#   /** MySQL database password */ define('DB_PASSWORD', 'vagrant'); 
#   /** MySQL hostname */ define('DB_HOST', '127.0.0.1'); 
#   /** Database Charset to use in creating database tables. */ define('DB_CHARSET', 'utf8'); 
#   /** The Database Collate type. Dont change this if in doubt. */ define('DB_COLLATE', '');

# restart
sudo systemctl restart apache2.service 
sudo systemctl restart mysql.service 

# Open link in a browser :   http://192.168.99.99/wordpress/wp-admin/
