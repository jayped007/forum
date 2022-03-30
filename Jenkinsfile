pipeline {
    agent any

    stages {
        stage('JGP') {
            steps {
                echo 'Adding temporary stage, to test webhook and GITHUB push interaction'
            }
        }
        stage('Build') {
            steps {
                echo 'Building..(STAGING server)'
                sh 'ssh -o StrictHostkeyChecking=no forum_staging@192.168.0.22 \
                 "cd forum_cicd; \
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
                sh 'ssh -o StrictHostkeyChecking=no forum_staging@192.168.0.22 \
                 "cd forum_cicd; \
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
