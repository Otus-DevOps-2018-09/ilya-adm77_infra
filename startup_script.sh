#~/bin/bash

echo 'Installing Ruby'

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

echo 'Checking Ruby version'

ruby -v
bundle -v

echo 'Installation completed'
#!/bin/bash

echo 'Installing MongoDB'

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

sudo apt update
sudo apt install -y mongodb-org

echo 'Starting MongoDB'

sudo systemctl start mongod
sudo systemctl enable mongod

#!/bin/bash

echo 'Deploying application'

cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

echo 'Starting application'

puma -d

