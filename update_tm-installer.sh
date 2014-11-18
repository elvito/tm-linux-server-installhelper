#!/bin/bash
# alten Installer löschen
if [ -f ~/install_tmlinuxserver.sh ]
	then
		rm -f ~/install_tmlinuxserver.sh
		clear
		echo "Der alte Installer wurde entfernt, bitte beliebige Taste drücken um fortzufahren"
		read -sn1
	else
		clear
		echo "Kein alter Installer gefunden, fahre in 5 Sekunden fort mit dem Update"
		sleep 5s
fi
# Herunterladen
wget -P /tmp/testing -c https://github.com/elvito/tm-linux-server-installhelper/archive/master.zip 
#Entpacken nach /tmp
unzip /tmp/testing/master.zip -d /tmp/testing
#Den installer nach home kopieren
cp  /tmp/testing/tm-linux-server-installhelper-master/install_tmlinuxserver.sh ~/
# Ausführbar machen
chmod 755 ~/install_tmlinuxserver.sh
#Aufräumen nach Install
rm -rf /tmp/testing*
#Testen
if [ -f ~/install_tmlinuxserver.sh ]
	then
		clear
		echo "install_tmlinuxserver.sh wurde aktualisiert"
		exit 0
	else
		clear
		echo "irgendwas ist schief gelaufen"
		exit 1
fi
