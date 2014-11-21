#!/bin/bash
# alten Installer löschen
if [ -f ~/tm-linux-server-installhelper-master/install_tmlinuxserver.sh ]
	then
		rm -rf ~/tm-linux-server-installhelper-master
		clear
		echo "Der alte Installer wurde entfernt, bitte beliebige Taste drücken um fortzufahren"
		read -sn1
	else
		clear
		echo "Kein alter Installer gefunden, fahre in 5 Sekunden fort mit dem Update"
		sleep 5s
fi

# Herunterladen
wget -P /tmp -c https://github.com/elvito/tm-linux-server-installhelper/archive/master.zip

#Entpacken nach /tmp
unzip /tmp/master.zip -d ~/

# Ausführbar machen
chmod 755 ~/tm-linux-server-installhelper-master/install_tmlinuxserver.sh

#Aufräumen nach Install
rm -rf /tmp/master*

#Testen
if [ -f ~/tm-linux-server-installhelper-master/install_tmlinuxserver.sh ]
	then
		clear
		echo "install_tmlinuxserver.sh wurde aktualisiert"
		exit 0
	else
		clear
		echo "irgendwas ist schief gelaufen"
		exit 1
fi
