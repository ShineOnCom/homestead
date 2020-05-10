#!/bin/sh

# If you would like to do some extra provisioning you may
# add any commands you wish to this file and they will
# be run after the Homestead machine is provisioned.
#
# If you have user-specific configurations you would like
# to apply, you may also create user-customizations.sh,
# which will be run after this script.

# If you're not quite ready for Node 12.x
# Uncomment these lines to roll back to
# v11.x or v10.x

# Remove Node.js v12.x:
#sudo apt-get -y purge nodejs
#sudo rm -rf /usr/lib/node_modules/npm/lib
#sudo rm -rf //etc/apt/sources.list.d/nodesource.list

# Install Node.js v11.x
#curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
#sudo apt-get install -y nodejs

# Install Node.js v10.x
#curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
#sudo apt-get install -y nodejs

# If you need BETA imagick feature
# sudo apt-add-repository ppa:ondrej/php
# sudo apt-get install -y php7.2-dev pkg-config libmagickwand-dev
# sudo pecl install imagick-beta
# keep yours

# sudo bash -c 'echo -e "extension=imagick.so\n" >> /etc/php/7.2/mods-available/imagemagick.ini'
# sudo ln -sf /etc/php/7.2/mods-available/imagemagick.ini /etc/php/7.2/fpm/conf.d/20-imagemagick.ini
# sudo ln -sf /etc/php/7.2/mods-available/imagemagick.ini /etc/php/7.2/cli/conf.d/20-imagemagick.ini
# sudo service php7.2-fpm restart

sudo update-alternatives --set php /usr/bin/php7.2
sudo update-alternatives --set php-config /usr/bin/php-config7.2
sudo update-alternatives --set phpize /usr/bin/phpize7.2

echo ""
echo "---------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------"
echo "local.fulfillment.shineon.com"
echo "---------------------------------------------------------------------------------"

echo "RUNNING: $ composer install && composer dump-autoload"
composer install -d './fulfillment.shineon.com/'

echo "SKIPPING: $ php artisan clear-compiled && php artisan migrate --force"

echo "RUNNING: $ npm install"
npm --prefix ./fulfillment.shineon.com install ./fulfillment.shineon.com

echo ""
echo "---------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------"
echo "First timer? MORE DOCUMENTION HERE: https://github.com/ShineOnCom/homestead"
