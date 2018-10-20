#!/bin/bash


apt update
apt install -y ruby-full ruby-bundler build-essential

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

apt update
apt install -y mongodb-org

systemctl start mongod
systemctl enable mongod


cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

mkdir /bin/scripts
touch /etc/systemd/system/puma.service
touch /bin/scripts/puma-service.sh
chmod +x /etc/systemd/system/puma.service
chmod +x /bin/scripts/puma-service.sh

echo '[Unit]
Description=Puma Server 
After=network.target

[Service] 
WorkingDirectory=/bin/scripts
ExecStart=/bin/bash puma-service.sh
KillMode=process
 
[Install]
WantedBy=multi-user.target'>/etc/systemd/system/puma.service

echo 'cd /home/appuser/reddit
puma -d'>/bin/scripts/puma-service.sh

systemctl enable puma.service
