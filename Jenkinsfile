pipeline {
    agent any

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
