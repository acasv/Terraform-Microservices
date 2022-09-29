#!/bin/bash
HOME='/home/ubuntu'

apt-get update

echo "---------------------------------Installing Java---------------------------------"
apt-get install -y openjdk-8-jdk
apt-get install -y maven
update-ca-certificates -f
java -version

echo "---------------------------------Installing Node---------------------------------"
curl -fsSL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install pm2
curl -sSL https://zipkin.io/quickstart.sh | bash -s
node -v ; npm -v

echo "---------------------------------Installing Redis---------------------------------"
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
apt-get update
apt-get install -y redis
apt install -y python3-pip

echo "---------------------------------Installing Go---------------------------------"
apt install -y snapd
snap install go --classic --channel=1.18/stable
go version

cd $HOME ; git clone -v https://AUTH_TOKEN@github.com/acasv/microservice-app-example.git

echo "---------------------------------Building Users-api---------------------------------"
cd $HOME/microservice-app-example/users-api/
./mvnw clean install

echo "---------------------------------Building Auth-api---------------------------------"
cd $HOME/microservice-app-example/auth-api/
export GO111MODULE=on
sudo go mod init github.com/acasv/microservice-app-example/tree/master/auth-api
sudo go mod tidy
sudo go build

echo "---------------------------------Building Todos-api---------------------------------"
cd $HOME/microservice-app-example/todos-api/
npm install

echo "---------------------------------Building Log-message-processor---------------------------------"
cd $HOME/microservice-app-example/log-message-processor/
pip3 install -r requirements.txt

echo "---------------------------------Running Backend---------------------------------"

echo "------1--------"
runuser -l ubuntu -c 'screen -dmS users bash -c "cd ~/microservice-app-example/users-api/ ; JWT_SECRET=PRFT SERVER_PORT=8083 java -jar target/users-api-0.0.1-SNAPSHOT.jar ; exec sh"'
echo "------2--------"
runuser -l ubuntu -c 'screen -dmS auth bash -c "cd ~/microservice-app-example/auth-api/ ; JWT_SECRET=PRFT AUTH_API_PORT=8000 USERS_API_ADDRESS=http://10.0.1.10:8083 ./auth-api ; exec sh"'
echo "------3--------"
runuser -l ubuntu -c 'screen -dmS todos bash -c "cd ~/microservice-app-example/todos-api/ ; JWT_SECRET=PRFT TODO_API_PORT=8082 npm start ; exec sh"'
echo "------4--------"
runuser -l ubuntu -c 'screen -dmS logredis bash -c "cd ~/microservice-app-example/log-message-processor/ ; REDIS_HOST=10.0.1.10 REDIS_PORT=6379 REDIS_CHANNEL=log_channel python3 main.py ; exec sh"'
echo "------5--------"
runuser -l ubuntu -c 'screen -dmS zipkin bash -c "cd ~/ ; java -jar zipkin.jar ; exec sh"'