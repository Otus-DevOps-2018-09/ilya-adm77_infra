#!/bin/bash

echo 'Deploying application'

cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install

echo 'Starting application'

puma -d


