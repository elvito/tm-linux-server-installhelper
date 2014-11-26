#!/bin/bash

# Variable definieren
DIALOG=dialog

#### Update von TM Linux Server #####

# Zunächst mal prüfen ob TM überhaupt installiert ist

if [ -d /opt/turbomed ]
	then
		$DIALOG --clear
		clear
		$DIALOG --msgbox "Eine Installation von Turbomed wurde gefunden" 0 0
			# Prüfen ob die Updatedatei von CGM in ~/Downloads liegt			
			if [ -f ~/Downloads/TMLinux*.zip ]
				then
					$DIALOG --clear
					clear
					$DIALOG --msgbox "Die Installationsdatei von CGM wurde in ~/Downloads gefunden" 0 0
					$DIALOG --msgbox "Beginne  nun mit dem Update... Dieser Vorgang wird ein bisschen dauern" 0 0
					# Zuerst evtl Rückstände aufräumen
					rm -rf ~/Downloads/TMWin					
					# Entpacken der Updatedatei					
					unzip -d ~/Downloads ~/Downloads/TMLinux-Version*.zip
					
					# Ausführbarmachen der TM_setup & TM_update
					chmod 755 ~/Downloads/TMWin/linux/bin/TM_setup
					chmod 755 ~/Downloads/TMWin/linux/bin/TM_update

					# Starte Updatevorgang
					~/Downloads/TMWin/linux/bin/TM_setup -u
					$DIALOG --msgbox "Der Updatevorgang wurde abgeschlossen" 0 0
					$DIALOG --clear
					clear
					exit 0
				else
					
					$DIALOG --msgbox "Die Installationsdatei von CGM wurde nicht in ~/Downloads gefunden" 0 0
					$DIALOG --msgbox "Bitte kopieren Sie zuerst die Installationsdatei von CGM nach ~/Downloads" 0 0
					$DIALOG --clear
					clear
					exit 1
			fi
	else
		$DIALOG --msgbox "Keine Installation von Turbomed gefunden... breche Updatevorgang ab" 0 0
		$DIALOG --clear
		clear
		exit 1
fi
