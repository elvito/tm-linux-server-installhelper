#!/bin/bash

# Logging aktivieren
# exec > >(tee ./install_tmlinuxserver.log)
# exec 2>&1

#### Sind wir root? ####
if [ "$(whoami)" != "root" ];
	then
		echo "Sie sind nicht root!"
		echo "Starten Sie das Programm mit sudo"
		echo "Das Programm wird jetzt beendet"
		exit 1
	else
		echo "Benutzer ist root"
		sleep 3s
fi

#### Prüfen der Internetverbindung ####
PING=`ping -c 1 8.8.8.8 | grep "64 bytes" | cut -b 1-2`
if [ "$PING" = "64" ]
	then
		echo "Internet connected"
		sleep 3s	
	else
		echo "Sie sind nicht mit dem Internet verbunden!"
		echo "Das Programm wird jetzt beendet"
		exit 1
fi

#### Zunächst mal die absoluten Basics installieren ####
apt-get update
apt-get install dialog openssh-server build-essential dkms unzip samba

#### Definiere verwendete verwendete Programme #### 
DIALOG=dialog
APTGET=apt-get

#### Beginn der Schleife ####
while true; do

#### Die Variable "choice" wird definiert ####
choice=`$DIALOG --menu \
	"Auswahl" 0 0 0 \
	"Ubuntu Systemupdate" "" \
	"Einrichtung von Samba" "" \
	"Installation von TM Linux Server" "" \
	"Einrichtung von iptables (Firewall)" "" \
	"Einrichtung eines versionierten Backups" "" \
	"Rebooten" "" \
	"Den Rechner herunterfahren" "" \
	"Vollständiges Entfernen von TM Linux Server" "" \
	"Vollständiges Entfernen von tm-linux-server-installhelper" "" \
	"Dieses Programm beenden" "" 3>&1 1>&2 2>&3`
	$DIALOG --clear
	clear

#### Weiterverarbeitung der Variablen "choice" ####
case "$choice" in

	# Ubuntu auf den aktuellsten Stand bringen
	"Ubuntu Systemupdate")
	$DIALOG --clear
	clear
	$APTGET update
	$APTGET upgrade
	$APTGET dist-upgrade
	$APTGET autoremove
	$DIALOG --msgbox "Sie sollten jetzt den Installer beenden und den PC neu starten" 0 0
	$DIALOG --msgbox "Führen Sie anschließend erneut \"sudo install_tmlinuxserver.sh\" aus" 0 0
	;;

	# Aufruf von tm_smbconf.sh
	"Einrichtung von Samba")
	bash ~/tm-linux-server-installhelper/installerscripts/tm_smbconf.sh
	;;
	
	# Aufruf des Vorbereitungsscripts
	"Installation von TM Linux Server")
	$DIALOG --clear
	clear
	bash ~/tm-linux-server-installhelper/installerscripts/tm-linux-server-vorbereitungsscript.sh 
	;;

	# Aufruf von tm_iptablesconf.sh
	"Einrichtung von iptables (Firewall)")
	$DIALOG --clear
	clear
	bash ~/tm-linux-server-installhelper/installerscripts/tm_iptables.sh 
	;;

	# Aufruf von tm_iptablesconf.sh
	"Einrichtung eines versionierten Backups")
	$DIALOG --clear
	clear
	bash ~/tm-linux-server-installhelper/installerscripts/tm_backup.sh 
	;;
	

	# Reboot
	"Rebooten")
	reboot
	;;

	# Reboot
	"Den Rechner herunterfahren")
	shutdown -h now
	;;

	# Aufruf von TM_setup -rm und löschen des FastObject Verzeichnisses aus /opt und ~/Downloads/TMWin
	"Vollständiges Entfernen von TM Linux Server")
	$DIALOG --clear
	clear
		if [ -d /opt/turbomed ]
			then
				/opt/turbomed/linux/bin/TM_setup -rm
				rm -rf /opt/FastObjects* 
				rm -rf ~/Downloads/TMWin 
				$DIALOG --msgbox "Löschen von TM Linux Server abgeschlossen" 0 0
				$DIALOG --clear
				clear
			else
				$DIALOG --msgbox "Turbomed Linux Server ist nicht installiert" 0 0
				$DIALOG --clear
				clear
		fi
	;;


	# Löschen aller Scripte
	"Vollständiges Entfernen von tm-linux-server-installhelper")
	$DIALOG --clear
	clear
		if [ -d ~/tm-linux-server-installhelper* ]
			then
				$DIALOG --infobox "tm-linux-server-installhelper wird entfernt" 0 0
		 		sleep 5s
		 		$DIALOG --clear
		 		rm -rf ~/tm-linux-server-installhelper*
				$DIALOG --msgbox "tm-linux-server-installhelper wurde entfernt" 0 0
			else
				$DIALOG --msgbox "tm-linux-server-installhelper ist noch nicht installiert" 0 0
				$DIALOG --clear
				clear
		fi
	;;
	
	# Ende
	"Dieses Programm beenden")
	exit 0
	;;
	
	# Alle anderen Fälle
	*)
	exit 1
	;;

esac
done
