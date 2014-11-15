#!/bin/bash

# Wechsel ins Downloadverzeichnis
cd ~/Downloads

# Prüfung ob die TM.zip vorhanden ist
if [ -f ~/Downloads/TMLinux-Version*.zip ]
	then
		clear	
		echo "Die Turbomedinstallationsdatei scheint vorhanden zu sein...fahre fort mit der Vorbereitung"
		read -sn1

		# Zusätzliche benötigte Pakete nachinstallieren
		clear
		echo "Installation zusätzlich benötigter Pakete <ENTER>"
		read -sn1
		sudo apt-get install gksu mc openssh-server samba samba-doc tdb-tools libc6:i386 libssl0.9.8:i386 libgcc1:i386 libstdc++6:i386 

		#Entpacken der TM Installationsdatei
		sudo unzip -d ~/Downloads ~/Downloads/TMLinux-Version*.zip

		# Ausführbarmachen der TM_setup & TM_update
		sudo chmod 755 ~/Downloads/TMWin/linux/bin/TM_setup
		sudo chmod 755 ~/Downloads/TMWin/linux/bin/TM_update

		# Installieren TM Server
		echo "Installiere Turbomed Server für Linux <ENTER>"
		read -sn1
		sudo ~/Downloads/TMWin/linux/bin/TM_setup -i
	else 
		clear	
		echo "Installationsdatei für den Linux Turbomed Server ist nicht im Downloadordner!!! Bitte kopieren Sie die gezippte TM Installationsdatei in den Ordner ~/Downloads <ENTER>"
		read -sn1
		exit 1
fi 


echo "Der Rechner wird in 20 Sekunden neu gestartet"
sleep 20s
sudo reboot 

exit 0

