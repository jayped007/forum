#!/bin/bash
pwd
cd forum
git pull origin main
composer install --optimize-autoloader --no-dev
php artisan migrate
php artisan cache:clear
php artisan config:cache
printf 'Completed deploy stage\n'
exit
