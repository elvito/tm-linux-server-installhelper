#!/bin/bash
# nicht vergessen vor dem mergen den branch zu ändern!!!!

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
apt-get install git dialog

#### Definiere verwendete verwendete Programme #### 
DIALOG=dialog
APTGET=apt-get

#### Beginn der Schleife ####
while true; do

#### Die Variable "choice" wird definiert ####
choice=`$DIALOG --menu \
	"Auswahl" 0 0 0 \
	"Ubuntu Systemupdate" "" \
	"Installation von tm-linux-server-installhelper" "" \
	"Vollstandiges Entfernen von tm-linux-server-installhelper" "" \
	"Installation von TM Linux Server" "" \
	"Vollständiges Entfernen von TM Linux Server" "" \
	"Einrichtung von Samba" "" \
	"Einrichtung von iptables (Firewall)" "" \
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

	#### Installation der Scripte ####
	"Installation von tm-linux-server-installhelper")
	$DIALOG --clear
		if [ -d ~/tm-linux-server-scripte ]
			then
				$DIALOG --infobox "Der Installationsordner für die Scripte ist bereits vorhanden...\n\nBeginne mit dem synchronisieren" 0 0
				sleep 5s
				$DIALOG --clear
				cd ~/tm-linux-server-scripte
				git checkout testing
				git pull https://github.com/elvito/tm-linux-server-installhelper.git
			else
				$DIALOG --infobox "Der Installationsordner für die Scripte wird neu angelegt, beginne in 5 Sekunden mit dem Clonen des Repository" 0 0
				sleep 5s
				$DIALOG --clear
				$DIALOG --msgbox "Die Scripte werden unter ~/tm-linux-server-scripte/ gespeichert" 0 0
				$DIALOG --clear
				git clone git://github.com/elvito/tm-linux-server-installhelper.git ~/tm-linux-server-scripte
				cd ~/tm-linux-server-scripte
				git checkout testing
				git pull https://github.com/elvito/tm-linux-server-installhelper.git
				$DIALOG --msgbox "Die Scripte wurden erfolgreich im Ordner ~/tm-linux-server-scripte/ installiert :)" 0 0
				$DIALOG --clear	    	
		fi
	;;
	
	# Löschen aller Scripte
	"Vollstandiges Entfernen von tm-linux-server-installhelper")
	$DIALOG --clear
		if [ -d ~/tm-linux-server-scripte ]
			then
				$DIALOG --infobox "tm-linux-server-installhelper wird entfernt" 0 0
		 		sleep 5s
		 		$DIALOG --clear
		 		rm -rf ~/tm-linux-server-scripte
				$DIALOG --msgbox "tm-linux-server-installhelper wurde entfernt" 0 0
			else
				$DIALOG --msgbox "tm-linux-server-installhelper ist noch nicht installiert" 0 0
				$DIALOG --clear
				clear
		fi
	;;
	
	# Aufruf des Vorbereitungsscripts
	"Installation von TM Linux Server")
	$DIALOG --clear
	clear
	bash ~/tm-linux-server-scripte/installerscripts/tm-linux-server-vorbereitungsscript.sh 
	;;

	# Aufruf von TM_setup -rm und löschen des FastObject Verzeichnisses aus /opt
	"Vollständiges Entfernen von TM Linux Server")
	$DIALOG --clear
	clear
		if [ -d /opt/turbomed ]
			then
				/opt/turbomed/linux/bin/TM_setup -rm
				rm -rf /opt/FastObjects* 
				$DIALOG --infobox "Löschen von TM Linux Server abgeschlossen" 0 0
				$DIALOG --clear
				clear
			else
				$DIALOG --msgbox "Turbomed Linux Server ist nicht installiert"
				$DIALOG --clear
				clear
		fi
	;;
	
	# Aufruf von tm_smbconf.sh
	"Einrichtung von Samba")
	bash ~/tm-linux-server-scripte/installerscripts/tm_smbconf.sh
	;;

	# Aufruf von tm_iptablesconf.sh
	"Einrichtung von iptables (Firewall)")
	$DIALOG --msgbox "Diese Option ist noch nicht implementiert" 0 0
	$DIALOG --clear
	clear
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
