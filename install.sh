# This script will install Mysql, Apache, PHP and its plugin to run basic Wordpress site.

# Update Ubuntu Vagrant box.
sudo apt-get update

# https://www.tecmint.com/install-wordpress-on-ubuntu-16-04-with-lamp/
# php and modules
sudo apt-get install -y php apache2 libapache2-mod-php php-curl php-gd php-mcrypt php-readline php-mysql git-core php-xdebug

# database
sudo apt-get install mysql-client mysql-server

# Setting root password or mysql root user.
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

# Adding python repo
sudo apt-get install -y vim curl python-software-properties
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update

# Install Composer for PHP package manager.
sudo curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Configure Apache to nables the specified module within the apache2 configuration, it will create symlinks.
sudo a2enmod rewrite
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/apache2/php.ini
sudo sed -i "s/disable_functions = .*/disable_functions = /" /etc/php/7.0/apache2/php.ini

# Add XDebug on php.ini
sudo cat <<EOT >> /etc/php/7.0/apache2/php.ini
[Xdebug]
xdebug.remote_enable = 1
xdebug.remote_autostart = 1
xdebug.remote_connect_back = 1
EOT

# Restart Apache server
sudo service apache2 restart