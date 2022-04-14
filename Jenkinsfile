pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..(STAGING server)'
                sh 'ssh -o StrictHostkeyChecking=no jenkins_staging@jenkins.jgp "bash -x forum/cicd/build_stage.bash"'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..(STAGING server)'
                sh 'ssh -o StrictHostkeyChecking=no jenkins_staging@jenkins.jgp "bash -x forum/cicd/test_stage.bash"'
            }
        }
        stage('Deploy') {
            input {
                message "Approve deployment?"
                ok "Approve deployment to PRODUCTION"
            }
            steps {
                echo 'Deploying....(PROD server)'
                sh 'ssh -o StrictHostkeyChecking=no jenkins_deploy@prod.jgp "bash -x forum/cicd/deploy_stage.bash"'
            }
        }
    }
}
