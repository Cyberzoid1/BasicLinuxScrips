#!/bin/bash

#pre req steps to run this script
# sudo apt-get install git
# mkdir $HOME/bin
# cd $HOME/bin
# git clone https://github.com/Cyberzoid1/BasicLinuxScripts.git
# ensure executable  chmod +x $HOME/bin/BasicLinuxScripts/setupScripts/newserver.sh
# ./$HOME/bin/BasicLinuxScripts/setupScripts/newserver.sh

echo "Starting Update"
echo ""
sudo apt-get update
echo "-----upgrade"
sudo apt-get -y upgrade

echo "-----java install" #http://askubuntu.com/questions/464755/how-to-install-openjdk-8-on-14-04-lts
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default
java -version

echo "-----installs"
sudo apt-get install -y inxi htop screen git build-essential
sudo apt-get install -y openssh-server openssh-client
echo "------update/upgrade/autoremove"
sudo apt-get -y update
sudo apt-get upgrade
sudo apt-get autoremove

echo "Updating path"
sudo export PATH=$PATH:$HOME/bin

#This was probably already setup
echo "Creating User Bin"
mkdir $HOME/bin

echo "Configuring git"
git config --global user.email n2143_sites2@outlook.com
git config --global user.name "Nick Krenowicz"

#Create sybolic link for update script.  PATH variable is setup only to $HOME/bin
ln -s $HOME/bin/BasicLinuxScripts/update $HOME/bin/update

echo "Recommend to reboot"
echo "Then do sudo apt-get dist-upgrade  if desired"
