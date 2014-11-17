#!/bin/bash

DIALOG=dialog

# Zunächst mal prüfen ob Turbomed schon installiert ist
if [ -d /opt/turbomed ]
	then
		#Zurück zum Installer
		$DIALOG --msgbox "Turbomed ist bereits installiert!" 0 0
		$DIALOG --msgbox "Löschen Sie zuerst die alte Installation" 0 0
		exit 0
	else
		# Bedingungen prüfen
		if [ -f ~/Downloads/TMLinux-Version*.zip ]
			then
				# TMLinux-Version*.zip ist vorhanden!		
				clear	
				$DIALOG --msgbox "Die Turbomedinstallationsdatei scheint vorhanden zu sein...fahre fort mit der Vorbereitung" 0 0
				$DIALOG --clear
				clear
		
				# Benötigte Pakete nachinstallieren
				$DIALOG --msgbox "Installation zusätzlich benötigter Pakete" 0 0
				$DIALOG --clear
				clear
				apt-get install gksu mc openssh-server samba samba-doc tdb-tools libc6:i386 libssl0.9.8:i386 libgcc1:i386 libstdc++6:i386

				# Entpacken der TM Installationsdatei
				$DIALOG --msgbox "Entpacken der CGM TM Installationsdatei" 0 0
				$DIALOG --clear
				clear
				unzip -d ~/Downloads ~/Downloads/TMLinux-Version*.zip

				# Ausführbarmachen der TM_setup & TM_update
				chmod 755 ~/Downloads/TMWin/linux/bin/TM_setup
				chmod 755 ~/Downloads/TMWin/linux/bin/TM_update

				# Installieren des TM Server
				$DIALOG --msgbox "Installiere Turbomed Server für Linux" 0 0
				$DIALOG --clear
				clear
				~/Downloads/TMWin/linux/bin/TM_setup -i
		
				# Test der Installation
					if [ -f /etc/init.d/poetd ]
				  		then
				    			$DIALOG --infobox "Überprüfung ob der FastObjectServer funktioniert..." 0 0
				    			sleep 3s
				    			$DIALOG --clear
				    			clear
				    			/etc/init.d/poetd start
				    			sleep 2s
				    			clear
				    			/etc/init.d/poetd status
				    			echo -e "\n\nSie sollten eine PID und \"running\" sehen\nBitte eine beliebige Taste drücken"
				    			read -sn1
						else
							$DIALOG --msgbox "Irgendwas ist schief gelaufen..." 0 0
							$DIALOG --msgbox "Melden Sie sich mit einer Fehlerbeschreibung im Forum" 0 0
							exit 1
					fi	

		# Bedingungen prüfen wird hier fortgesetzt
			else 
		    		$DIALOG --msgbox "Installationsdatei für den Linux Turbomed Server ist nicht im Downloadordner!" 0 0
		    		$DIALOG --msgbox "Bitte kopieren Sie die gezippte TM Installationsdatei in den Ordner ~/Downloads" 0 0
		    		$DIALOG --clear
		    		clear
		    		exit 1

		fi 
fi
# Abschliessende Mitteilung an den Benutzer
if [ -d /opt/turbomed ]
	then
		$DIALOG --msgbox "Die Installation von Turbomed Linux Server war erfolgreich :)" 0 0
		$DIALOG --msgbox "Sie sollten als nächstes Samba einrichten" 0 0
		$DIALOG --clear
		clear
	else
		$DIALOG --msgbox "Irgendwas ist schief gelaufen..." 0 0
		$DIALOG --msgbox "Überprüfen Sie ob sich die Turbomed Linux Server Datei der Firma CGM im Ordner ~/Downloads befindet" 0 0
		$DIALOG --msgbox "Andernfalls melden Sie sich mit einer Fehlerbeschreibung im Forum" 0 0
		$DIALOG --clear
		clear
fi

exit 0
