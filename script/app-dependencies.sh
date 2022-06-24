cd /var/www/laravel-code/
  sudo chown -R $USER:www-data storage
  sudo chown -R $USER:www-data bootstrap/cache
  sudo apt install -y npm
  php artisan 
  cd ~
  sudo systemctl reload nginx 