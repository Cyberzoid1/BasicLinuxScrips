#!/bin/bash

#https://software.opensuse.org/download.html?project=home%3Aemby&package=emby-server
echo "install for 16.04"
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/emby/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/emby-server.list"
wget http://download.opensuse.org/repositories/home:emby/xUbuntu_16.04/Release.key
sudo apt-key add - < Release.key
sudo apt-get update
sudo apt-get install emby-server
sudo service emby-server start

echo "installing ffmpeg"
sudo apt-get install ffmpeg
 
echo "installing samba server"
sudo apt-get install samba