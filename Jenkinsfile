pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..(STAGING server)'
                sh 'ssh -o StrictHostkeyChecking=no forum_staging@jenkins.jgp \
                 "cd forum; \
                  git pull origin main; \
                  composer install --optimize-autoloader; \
                  php artisan migrate; \
                  php artisan cache:clear; \
                  php artisan config:cache"'
                  // NOTE: could add 'npm install' et al to compile assets
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..(STAGING server)'
                sh 'ssh -o StrictHostkeyChecking=no forum_staging@jenkins.jgp \
                 "cd forum; \
                  php artisan cache:clear; \
                  php artisan config:cache; \
                  vendor/bin/phpunit"'
            }
        }
        stage('Deploy') {
            input {
                message "Approve deployment?"
                ok "Approve deployment to PRODUCTION"
            }
            steps {
                echo 'Deploying....'
                sh 'ssh -o StrictHostkeyChecking=no forum_deploy@prod.jgp \
                 "cd forum; \
                  git pull origin main; \
                  composer install --optimize-autoloader --no-dev; \
                  php artisan migrate; \
                  php artisan cache:clear; \
                  php artisan config:cache"'
            }
        }
    }
}
