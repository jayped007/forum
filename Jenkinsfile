pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..(on staging)'
                sh 'ssh -o StrictHostkeyChecking=no forum_staging@192.168.0.22 \
                 "cd forum_cicd; \
                  git pull origin main; \
                  composer install --optimize-autoloader --no-dev; \
                  php artisan migrate; \
                  php artisan cache:clear; \
                  php artisan config:cache"'
                  // NOTE: could add 'npm install' et al to compile assets
            }
        }
        stage('Test..(on staging)') {
            steps {
                echo 'Testing..'
                sh 'ssh -o StrictHostkeyChecking=no forum_staging@192.168.0.22 \
                 "cd forum_cicd; \
                  php artisan cache:clear; \
                  php artisan config:cache; \
                  vendor/bin/phpunit"'
            }
        }
        stage('Deploy..(to PROD)') {
            steps {
                echo 'Deploying....'
                sh 'ssh -o StrictHostkeyChecking=no forum_deploy@192.168.0.19 \
                 "cd forum_cicd; \
                  git pull origin main; \
                  composer install --optimize-autoloader --no-dev; \
                  php artisan migrate; \
                  php artisan cache:clear; \
                  php artisan config:cache"'
            }
        }
    }
}
