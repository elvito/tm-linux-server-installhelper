#!/bin/bash

#### Sind wir root? ####
if [ "$(whoami)" != "root" ];
	then
		echo "Sie sind nicht root!"
		echo "Starten Sie das Programm mit sudo"
		echo "Das Programm wird jetzt beendet!"
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
	"Dieses Menü beenden" "" 3>&1 1>&2 2>&3`
	$DIALOG --clear
	clear

#### Weiterverarbeitung der Variablen "choice" ####
case "$choice" in

	"Ubuntu Systemupdate")
	$DIALOG --clear
	clear
	$APTGET update
	$APTGET upgrade
	$APTGET dist-upgrade
	$APTGET autoremove
	;;

	"Installation von tm-linux-server-installhelper")
	$DIALOG --clear
		if [ -d ~/tm-linux-server-scripte ]
			then
				$DIALOG --infobox "Der Installationsordner für die Scripte ist bereits vorhanden...\n\nBeginne mit dem synchronisieren" 0 0
				sleep 5s
				$DIALOG --clear
				cd ~/tm-linux-server-scripte
				git pull https://github.com/elvito/tm-linux-server-installhelper.git testing
			else
				$DIALOG --infobox "Der Installationsordner für die Scripte wird neu angelegt, beginne in 5 Sekunden mit dem Clonen des Repository" 0 0
				sleep 5s
				$DIALOG --clear
				$DIALOG --msgbox "Die Scripte werden unter ~/tm-linux-server-scripte/ gespeichert" 0 0
				$DIALOG --clear
				mkdir ~/tm-linux-server-scripte
				cd ~/tm-linux-server-scripte
				git clone git://github.com/elvito/tm-linux-server-installhelper.git .
				$DIALOG --msgbox "Die Scripte wurden erfolgreich im Ordner ~/tm-linux-server-scripte/ installiert :)" 0 0
				$DIALOG --clear	    	
		fi
	;;
	
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
				$DIALOG --msgbox "tm-linux-server-installhelper ist nicht installiert" 0 0
				$DIALOG --clear
				clear
		fi
	;;
	
	"Installation von TM Linux Server")
	$DIALOG --clear
	clear
	~/tm-linux-server-scripte/tm-linux-server-vorbereitungsscript.sh 
	$DIALOG --infobox "Überprüfung ob der FastObjectServer läuft..." 0 0
	sleep 3s
	$DIALOG --clear
	clear
	/etc/init.d/poetd start
	sleep 2s
	clear
	/etc/init.d/poetd status
	echo -e "\n\nSie sollten eine PID und \"running\" sehen\nBitte eine beliebige Taste drücken"
	read -sn1
		if [ -d /opt/turbomed ]
			then
				$DIALOG --msgbox "Die Installation von Turbomed Linux Server war erfolgreich :)" 0 0
				$DIALOG --clear
				clear
			else
				$DIALOG --msgbox "Irgendwas ist schief gelaufen..." 0 0
				$DIALOG --msgbox "Melden Sie sich mit einer Fehlerbeschreibung im Forum" 0 0
				$DIALOG --clear
				clear
		fi
	;;

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

	"Einrichtung von Samba")
		if [ -d ~/tm-linux-server-scripte/ ]
			then
				$DIALOG --msgbox "Installiere die angepasste smb.conf und starte anschließend Samba neu" 0 0
				$DIALOG --clear
				clear
				cp -b ~/tm-linux-server-scripte/smb.conf /etc/samba/
				chmod 644 /etc/samba/smb.conf
				service samba restart
				$DIALOG --infobox "Einrichtung des angepassten smb.conf abgeschlossen, Samba wurde neu gestartet" 0 0
				$DIALOG --clear
				clear
			else
				$DIALOG --msgbox "Installieren Sie zuerst tm-linux-server-installhelper" 0 0
				$DIALOG --clear
				clear
		fi
	;;

	"Einrichtung von iptables (Firewall)")
	$DIALOG --msgbox "Diese Option ist noch nicht implementiert" 0 0
	$DIALOG --clear
	clear
	;;

	"Dieses Menü beenden")
	exit 0
	;;

	*)
	exit 1
	;;

esac
done
