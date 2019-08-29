#!/bin/bash

apt-get update
apt-get -y install git docker.io

useradd -m -s /bin/bash webadmin
docker build -t "kalbestore:v1" .
docker run -itd -p 80:80 -p 443:443 -v /home/webadmin/sites:/home/webadmin/sites --name kalbestore kalbestore

