#!/bin/bash
pwd
cd forum
git pull origin main
php artisan cache:clear
php artisan config:cache
vendor/bin/phpunit
printf 'Completed test stage\n'
exit
