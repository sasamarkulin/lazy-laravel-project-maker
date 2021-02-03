#!/bin/sh

read -p "What will the name of your project be? " name
vhosts="/c/wamp64/bin/apache/apache2.4.41/conf/extra/httpd-vhosts.conf"
hosts="/c/Windows/System32/drivers/etc/hosts"
composer selfupdate
composer global require laravel/installer
composer create-project laravel/laravel /c/wamp64/www/$name
echo "

<VirtualHost *:80>
  ServerName dev.name.hr
  ServerAlias dev.name.hr
  DocumentRoot '${INSTALL_DIR}/www/name/public'
  <Directory '${INSTALL_DIR}/www/name/public/'>
    Options +Indexes +Includes +FollowSymLinks +MultiViews
    AllowOverride All
    Require local
  </Directory>
</VirtualHost>" >> $vhosts
sed -i "s/name/$name/" $vhosts
echo "
127.0.0.1 dev.$name.hr" >> $hosts
cd "/c/wamp64/www/$name"
npm install
npm run dev
git init
git add .
git commit -m "Initial commit"
start .
code .
