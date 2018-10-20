#!/bin/bash

echo 'Installing Ruby'

sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

echo 'Checking Ruby version'

ruby -v
bundle -v

echo 'Installation completed'
