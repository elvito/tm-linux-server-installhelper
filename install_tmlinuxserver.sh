#!/bin/bash

#### Zunächst mal die absoluten Basics installieren ####
#apt-get update
#apt-get install git dialog

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
	"Installation von TM Linux Server" "" \
	"Vollständiges Entfernen von TM Linux Server" "" \
	"Einrichtung von Samba" "" \
	"Einrichtung von iptables (Firewall)" "" \
	"Dieses Menü beenden" "" 3>&1 1>&2 2>&3`
#	$DIALOG --clear
#	$DIALOG --yesno "Bestätigen Sie Ihre Auswahl: $choice" 0 0
	$DIALOG --clear
	clear

#### Weiterverarbeitung der Variablen "choice" ####
case "$choice" in

	"Ubuntu Systemupdate")
	$DIALOG --clear
	clear
	APTGET update
	APTGET upgrade
	APTGET dist-upgrade
	APTGET autoremove
	;;

	"Installation von tm-linux-server-installhelper")
	$DIALOG --clear
		if [ -d ~/tm-linux-server-scripte ]
			then
				$DIALOG --infobox "Der Installationsordner für die Scripte ist bereits vorhanden... Beginne mit dem synchronisieren" 5 40
		 		sleep 5s
		 		$DIALOG --clear
		 		cd ~/tm-linux-server-scripte
		 		git clone git://github.com/elvito/tm-linux-server-installhelper.git .
			else
		 		$DIALOG --infobox "Der Installationsordner für die Scripte wird neu angelegt, beginne in 5 Sekunden mit dem synchronisieren" 5 40
		 		sleep 5s
		 		$DIALOG --clear
		 		$DIALOG --msgbox "Die Scripte werden unter ~/tm-linux-server-scripte/ gespeichert" 5 40
		 		$DIALOG --clear
		 		mkdir ~/tm-linux-server-scripte
		 		cd ~/tm-linux-server-scripte
		 		git clone git://github.com/elvito/tm-linux-server-installhelper.git .
		 		$DIALOG --msgbox "Die Scripte wurden erfolgreich im Ordner ~/tm-linux-server-scripte/ installiert :)" 5 40
				$DIALOG --clear	    	
	    	fi
	;;

	"Installation von TM Linux Server")
	$DIALOG --clear
	clear
	cd ~/tm-linux-server-scripte
	sudo ./tm-linux-server-vorbereitungsscript.sh >1
	#$DIALOG --msgbox "Der TM Linux Server wurde installiert :)" 5 40
	#$DIALOG --clear
	#$DIALOG --infobox "Überprüfung ob der FastObjectServer läuft beginnt in 5 Sekunden" 5 40
	sleep 5s
	#$DIALOG --clear
	clear
	/etc/init.d/poet status
	echo -e "\n\nSie sollten eine PID und \"running\" sehen\nBitte eine beliebige Taste drücken" 5 40
	read -sn1	
	$DIALOG --msgbox "Der TM Linux Server wurde installiert :)" 5 40
	$DIALOG --clear
	;;

	"Vollständiges Entfernen von TM Linux Server")
	$DIALOG --clear
	clear
	/opt/turbomed/TM_setup -rm
	#rm -f /opt/FastObject* 
	$DIALOG --infobox "Löschen von TM Linux Server abgeschlossen" 5 40
	$DIALOG --clear
	clear
	;;

	"Einrichtung von Samba")
		if [ -d ~/tm-linux-server-scripte/ ]
			then
				$DIALOG --msgbox "Installiere die angepasste smb.conf und starte anschließend Samba neu" 5 40
				sleep 5s
				$DIALOG --clear
				clear
				cp -b ~/tm-linux-server-scripte/smb.conf /etc/samba/
				chmod 644 /etc/samba/smb.conf
				service samba restart
				$DIALOG --infobox "Einrichtung des angepassten smb.conf abgeschlossen, Samba wurde neu gestartet" 5 40
				$DIALOG --clear
			else
				$DIALOG --msgbox "Installieren Sie zuerst tm-linux-server-installhelper" 5 40
				$DIALOG --clear
		fi
	;;

	"Einrichtung von iptables (Firewall)")
	$DIALOG --msgbox "Diese Option ist noch nicht implementiert" 5 60
	$DIALOG --clear
	;;

	"Dieses Menü beenden")
	exit 0
	;;

	*)
	exit 1
	;;

esac
done
