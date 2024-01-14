sudo docker stop restheart
sudo docker stop mongodb
sudo docker rm restheart
sudo docker rm mongodb
mkdir data
sudo docker run -d -e MONGO_INITDB_ROOT_USERNAME='restheart' -e MONGO_INITDB_ROOT_PASSWORD='R3ste4rt!'  --name mongodb -v "$PWD/data:/data/db" -v "$PWD/Catalogue:/Catalogue" mongo:3.6 --bind_ip_all --auth
sleep 20
sudo docker  exec  mongodb mongoimport  -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection videos --drop --file /Catalogue/videos.json
sudo docker  exec  mongodb mongoimport  -u restheart -p R3ste4rt! --authenticationDatabase admin --db myflix --collection categories --drop --file /Catalogue/categories.json
sudo docker run -d -p 80:8080 --name restheart --link mongodb:mongodb softinstigate/restheart:4.1.0