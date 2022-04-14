#!/bin/bash
pwd
cd forum
git pull origin main
composer install --optimize-autoloader
php artisan migrate
php artisan cache:clear
php artisan config:cache
# NOTE: could add 'npm install' et al to compile assets
printf 'Completed build stage\n'
exit
