pipeline {
    agent any
    environment{
        DOCKERHUB_CREDENTIALS = credentials('kaychucool')
    }
    stages {
        stage('Build') {
            steps {
                script {
                    sh 'chmod +x ./build.sh'
                    sh './build.sh'
                }
            }
        }       
    }
}
