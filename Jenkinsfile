pipeline {
    agent {
        docker { image 'node:20.10.0-alpine3.19' }
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
