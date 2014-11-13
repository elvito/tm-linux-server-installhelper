#!/bin/bash
sudo apt-get update
sudo apt-get install git
if [ -d ~/tm-linux-server-scripte ];then
	echo "Der Installationsordner für die Scripte ist bereits vorhanden beginne in 5 Sekunden mit dem synchronisieren"
	sleep 5s
	cd ~/tm-linux-server-scripte
	git clone git://https://github.com/elvito/tm-linux-server-installhelper.git .
else
	echo "Der Installationsordner für die Scripte ist noch nicht vorhanden!"
	echo "Die Scripte werden unter ~/tm-linux-server-scripte/ gespeichert"
	sleep 5s
	mkdir ~/tm-linux-server-scripte
	cd ~/tm-linux-server-scripte
	git clone git://https://github.com/elvito/tm-linux-server-installhelper.git .
fi
exit 0
