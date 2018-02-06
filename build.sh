#!/bin/sh

# Installing docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get -y install docker-ce

# Setting executable files
chmod +x ./matomo/docker-entrypoint.sh

# Config /etc/hosts with container IP
sh -c "printf '\n172.18.0.10 nginx\n' >> /etc/hosts"

# Installing nginx dispatcher
apt-get install nginx
rm -rf /etc/nginx/sites-available
rm -rf /etc/nginx/sites-enabled
rm -rf /etc/nginx/nginx.conf
rm -rf /etc/nginx/nginx.conf
ln -f ./dispatcher/nginx.conf /etc/nginx/nginx.conf
ln -s ~/matomo-docker-compose/dispatcher/config /etc/nginx/conf.d
ln -s ~/matomo-docker-compose/dispatcher/sites /etc/nginx/sites-available
ln -s ~/matomo-docker-compose/dispatcher/sites /etc/nginx/sites-enabled

service nginx restart

# Installing docker-compose
apt-get install docker-compose

# Build docker images
docker-compose build

# Deploy docker containers
docker-compose up -d