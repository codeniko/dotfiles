#!/bin/bash

# Things to manually install
# Ulauncher https://ulauncher.io/#Download

apt-get install -y telnet dnsutils curl vim git redshift

curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
# Verify node and npm versions
node -v; npm -v

npm install -g diff-so-fancy
