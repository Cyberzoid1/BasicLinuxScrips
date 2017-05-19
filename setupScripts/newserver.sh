#!/bin/bash

echo Starting Update
echo ""
sudo apt-get update
echo -----upgrade
sudo apt-get -y upgrade

echo -----java install #http://askubuntu.com/questions/464755/how-to-install-openjdk-8-on-14-04-lts
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default
java -version

echo -----installs
sudo apt-get install -y inxi htop screen
sudo apt-get install -y openssh-server openssh-client
echo ------updae/upgrade/autoremove
sudo apt-get -y update
sudo apt-get upgrade
sudo apt-get autoremove
echo -------shutdown
shutdown -h 2
