#!/bin/bash

#pre req steps to run this script
# sudo apt-get install git
# mkdir $HOME/bin
# cd $HOME/bin
# git clone https://github.com/Cyberzoid1/BasicLinuxScripts.git
# ensure executable  chmod +x $HOME/bin/BasicLinuxScripts/setupScripts/newserver.sh
# ./$HOME/bin/BasicLinuxScripts/setupScripts/newserver.sh

echo -e "Starting Update\n"
sudo apt-get update
echo -e "\n-----upgrade------"
sudo apt-get -y upgrade

echo -e "\n-----java install------" #http://askubuntu.com/questions/464755/how-to-install-openjdk-8-on-14-04-lts
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update
#set auto accept license
sudo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo apt-get install -y oracle-java8-installer
sudo apt-get install -y oracle-java8-set-default
java -version

echo -e "\n-----program installs------"
sudo apt-get install -y inxi htop screen git build-essential
sudo apt-get install -y openssh-server openssh-client
# Other packages to note: ubuntu-restricted-extras cmake
echo -e "\n------update"
sudo apt-get update
echo -e "\n------upgrade------"
sudo apt-get -y upgrade
echo -e "\n------autoremove------"
sudo apt-get -y autoremove

echo -e "\n------Updating path------"
sudo export PATH=$PATH:$HOME/bin
#Create sybolic link for update script.  PATH variable is setup only to $HOME/bin
ln -s $HOME/bin/BasicLinuxScripts/update $HOME/bin/update

#This was probably already setup
echo -e "\n------Creating User Bin------"
mkdir $HOME/bin

echo -e "\n------Configuring git------"
git config --global user.email n2143_sites2@outlook.com
git config --global user.name "Nick Krenowicz"
echo -e "------Done------"
echo -e "\n\nRecommend to reboot"
echo "Then do sudo apt-get dist-upgrade  if desired"
