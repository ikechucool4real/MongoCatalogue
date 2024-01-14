pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'mongodb'
    }

    stages {
        stage('Create Data Directory') {
            steps {
                script {
                    sh 'mkdir data'
                }
            }
        }

        stage('Run and Import MongoDB Data') {
            steps {
                script {
                    def mongoDBContainer = docker.image('mongo:3.6').run('-d -e MONGO_INITDB_ROOT_USERNAME=restheart -e MONGO_INITDB_ROOT_PASSWORD=R3ste4rt! --name mongodb -v "$PWD/data:/data/db" -v "$PWD/Catalogue:/Catalogue" --bind_ip_all --auth')
                    sleep time: 20, unit: 'SECONDS'
                    
                    docker.image(mongodb).inside {
                        sh 'mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection videos --drop --file /Catalogue/videos.json'
                        sh 'mongoimport -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection categories --drop --file /Catalogue/categories.json'
                    }

                    mongoDBContainer.stop()
                }
            }
        }

        stage('Run Restheart Container') {
            steps {
                script {
                    docker.image('softinstigate/restheart:4.1.0').run('-d -p 80:8080 --name restheart --link mongodb:mongodb')
                }
            }
        }
    }
}
