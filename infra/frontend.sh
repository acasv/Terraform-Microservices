#!/bin/bash

HOME='/home/ubuntu'

sudo apt-get update

echo "---------------------------------Installing Node---------------------------------"
curl -fsSL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install pm2
node -v ; npm -v

cd $HOME ; git clone -v https://AUTH_TOKEN@github.com/acasv/microservice-app-example.git

echo "---------------------------------Building Frontend---------------------------------"
cd $HOME/microservice-app-example/frontend/
npm install
npm run build

echo "---------------------------------Running Frontend---------------------------------"
screen -dm bash -c "cd ~/microservice-app-example/frontend/ ; PORT=8080 AUTH_API_ADDRESS=http://10.0.1.10:8000 TODOS_API_ADDRESS=http://10.0.1.10:8082 npm start ; exec sh"
