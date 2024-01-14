pipeline {
    agent any

    stages {
        stage('Create Data Directory') {
            steps {
                script {
                    sh 'mkdir data'
                }
            }
        }

        stage('Run MongoDB Container') {
            steps {
                script {
                    sh 'sudo docker run -d -e MONGO_INITDB_ROOT_USERNAME=restheart -e MONGO_INITDB_ROOT_PASSWORD=R3ste4rt! --name mongodb -v "$PWD/data:/data/db" -v "$PWD/Catalogue:/Catalogue" mongo:3.6 --bind_ip_all --auth'
                    sleep time: 20, unit: 'SECONDS'
                }
            }
        }

        stage('Import MongoDB Data') {
            steps {
                script {
                    sh 'sudo docker exec mongodb mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection videos --drop --file /Catalogue/videos.json'
                    sh 'sudo docker exec mongodb mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection categories --drop --file /Catalogue/categories.json'
                }
            }
        }

        stage('Run Restheart Container') {
            steps {
                script {
                    sh 'sudo docker run -d -p 80:8080 --name restheart --link mongodb:mongodb softinstigate/restheart:4.1.0'
                }
            }
        }
    }
}