#!/bin/bash

DIALOG=dialog

# Prüfung ob die TM.zip vorhanden ist
if [ -f ~/Downloads/TMLinux-Version*.zip ]
	then
		clear	
		$DIALOG --msgbox "Die Turbomedinstallationsdatei scheint vorhanden zu sein...fahre fort mit der Vorbereitung" 5 40
		$DIALOG --clear
		clear
		
		# Zusätzliche benötigte Pakete nachinstallieren
		$DIALOG --msgbox "Installation zusätzlich benötigter Pakete" 5 40
		$DIALOG --clear
		clear
		apt-get install gksu mc openssh-server samba samba-doc tdb-tools libc6:i386 libssl0.9.8:i386 libgcc1:i386 libstdc++6:i386 

		#Entpacken der TM Installationsdatei
		$DIALOG --msgbox "Entpacken der TM Installationsdatei" 5 40
		$DIALOG --clear
		clear
		unzip -d ~/Downloads ~/Downloads/TMLinux-Version*.zip

		# Ausführbarmachen der TM_setup & TM_update
		chmod 755 ~/Downloads/TMWin/linux/bin/TM_setup
		chmod 755 ~/Downloads/TMWin/linux/bin/TM_update

		# Installieren TM Server
		$DIALOG --msgbox "Installiere Turbomed Server für Linux" 5 40
		$DIALOG --clear
		clear
		~/Downloads/TMWin/linux/bin/TM_setup -i
	else 
		$DIALOG --msgbox "Installationsdatei für den Linux Turbomed Server ist nicht im Downloadordner!!! Bitte kopieren Sie die gezippte TM Installationsdatei in den Ordner ~/Downloads" 5 40
		$DIALOG --clear
		clear
		exit 1
fi 
exit 0
