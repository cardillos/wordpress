# This script will install Mysql, Apache, PHP and its plugin to run basic Wordpress site.

# Install Apache
sudo apt-get -y install apache2 apache2-utils 

# php and modules
sudo apt-get -y install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd php-xdebug

# Add XDebug on php.ini
sudo cat <<EOT >> /etc/php/7.0/apache2/php.ini
[Xdebug]
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
xdebug.remote_connect_back = 1
EOT

# Install additional tools
sudo apt-get -y install unzip nano

# Setting root password or mysql root user.
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
# Database Installation
sudo apt-get -y install mysql-client mysql-server


# Configure Apache to nables the specified module within the apache2 configuration, it will create symlinks.
sudo a2enmod rewrite
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/apache2/php.ini
sudo sed -i "s/disable_functions = .*/disable_functions = /" /etc/php/7.0/apache2/php.ini

# Import database
# mysql -u root -p < importDatabase.sql
mysql -u root -p wordpress_52 < /var/www/wordpress_52_2018-04-23_02-04-18.sql
mysql -u root -p wordpress_52 < migration.sql

# Start Apache server
sudo service apache2 start
sudo service mysql start
