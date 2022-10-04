#!/bin/bash

HOME='/home/ubuntu'

apt update

echo "---------------------------------Installing java---------------------------------"
sudo apt install openjdk-11-jre-headless -y

echo "---------------------------------Installing Jenkins---------------------------------"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
sudo apt-get install jenkins -y

sudo sed -i 's/HTTP_PORT=8080/HTTP_PORT=8090/g' /etc/default/jenkins

echo "---------------------------------Enable Jenkins---------------------------------"
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo service jenkins restart

echo "---------------------------------Installing Node---------------------------------"
curl -fsSL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install pm2
node -v ; npm -v

cd $HOME ; git clone -v https://github.com/acasv/microservice-app-example.git

echo "---------------------------------Building Frontend---------------------------------"
cd $HOME/microservice-app-example/frontend/
npm install
npm run build

echo "---------------------------------Running Frontend---------------------------------"
screen -dm bash -c "cd ~/microservice-app-example/frontend/ ; PORT=8080 AUTH_API_ADDRESS=http://10.0.1.10:8000 TODOS_API_ADDRESS=http://10.0.1.10:8082 npm start ; exec sh"
