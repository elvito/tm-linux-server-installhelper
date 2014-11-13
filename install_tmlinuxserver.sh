#!/bin/bash
sudo apt-get update
sudo apt-get install git
if [ -d ~/tm-linux-server-scripte ];then
	cd ~/tm-linux-server-scripte
	git clone git://https://github.com/elvito/tm-linux-server-installhelper.git .
else
	mkdir ~/tm-linux-server-scripte
	cd ~/tm-linux-server-scripte
	git clone git://https://github.com/elvito/tm-linux-server-installhelper.git .
fi
exit 0