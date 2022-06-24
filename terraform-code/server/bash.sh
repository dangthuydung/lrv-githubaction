#!/bin/bash                                                                     
  sudo apt-get update
  sudo apt-get install -y ruby
  wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/releases/codedeploy-agent_1.0-1.1597_all.deb
  mkdir codedeploy-agent_1.0-1.1597_ubuntu20
  dpkg-deb -R codedeploy-agent_1.0-1.1597_all.deb codedeploy-agent_1.0-1.1597_ubuntu20
  sed 's/2.0/2.7/' -i ./codedeploy-agent_1.0-1.1597_ubuntu20/DEBIAN/control
  dpkg-deb -b codedeploy-agent_1.0-1.1597_ubuntu20
  sudo dpkg -i codedeploy-agent_1.0-1.1597_ubuntu20.deb
  sudo systemctl start codedeploy-agent
  sudo systemctl enable codedeploy-agent
  #----------------------------------------------------------------
  sudo apt -y update
  sudo apt install -y awscli
  sudo apt install -y nginx
  sudo systemctl start nginx
  sudo systemctl enable nginx

  sudo apt install -y mysql-server 
  sudo apt install -y php-fpm php-mysql 
  sudo apt install -y php-cli unzip 
  cd ~
  curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php 
  HASH=`curl -sS https://composer.github.io/installer.sig` 
  echo $HASH 
  php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" 
  sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer 
  composer
  sudo apt install -y php-mbstring php-xml php-bcmath 
  sudo aws s3 cp s3://laravel-bucket123abc/nginx.txt /etc/nginx/sites-enabled/danhsach
  cd /var/www
  mkdir laravel-code
  cd laravel-code/
  sudo chown -R $USER:www-data storage
  sudo chown -R $USER:www-data bootstrap/cache
  sudo apt install -y npm
  php artisan 
  cd ~
  sudo systemctl reload nginx 

  

