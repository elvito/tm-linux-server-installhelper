#!/bin/bash
# alten Installer löschen
if [ -f ~/tm-linux-server-installhelper/install_tmlinuxserver.sh ]
	then
		rm -rf ~/tm-linux-server-installhelper*
		clear
		echo "Der alte Installer wurde entfernt, bitte beliebige Taste drücken um fortzufahren"
		read -sn1
	else
		clear
		echo "Kein alter Installer gefunden, fahre in 3 Sekunden fort mit dem Update"
		sleep 3s
fi

# Herunterladen
wget -P /tmp -c https://github.com/elvito/tm-linux-server-installhelper/archive/testing.zip

#Entpacken nach /tmp
unzip /tmp/testing.zip -d /tmp

# Kopieren und umbenennen
mv /tmp/tm-linux-server-installhelper-testing ~/tm-linux-server-installhelper

# Markieren des Branch "testing"
touch ~/tm-linux-server-installhelper/testing

# Ausführbar machen
chmod 755 ~/tm-linux-server-installhelper-testing/install_tmlinuxserver.sh

#Aufräumen nach Install
rm -rf /tmp/testing*
rm -rf /tmp/tm-linux-server-installhelper-testing*

#Testen
if [ -f ~/tm-linux-server-installhelper/install_tmlinuxserver.sh ]
	then
		clear
		echo "install_tmlinuxserver.sh wurde aktualisiert"
		exit 0
	else
		clear
		echo "irgendwas ist schief gelaufen"
		exit 1
fi
