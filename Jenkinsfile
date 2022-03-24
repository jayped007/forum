pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'composer install'
                // npm install et al to compile assets
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'vendor/bin/phpunit'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
