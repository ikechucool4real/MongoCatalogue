pipeline {
    agent {
        docker { image 'jenkins/jenkins' }
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
