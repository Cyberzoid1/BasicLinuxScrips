#!/bin/bash

echo ""
echo Setting up teamspeak3
echo ""

sudo adduser --disabled-login teamspeak3
sudo mv teamspeak3 /usr/local/teamspeak3
sudo chown -R teamspeak3 /usr/local/teamspeak3
sudo chmod -R +x /usr/local/teamspeak3
sudo ln -s /usr/local/teamspeak3/ts3server_startscript.sh /etc/init.d/teamspeak3
sudo update-rc.d teamspeak3 defaults

echo ""
echo "First time starting teamspeak service"
echo ""
sudo service teamspeak3 start