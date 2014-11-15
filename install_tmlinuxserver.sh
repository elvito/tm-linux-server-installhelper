#!/bin/bash
#### Zunächst mal die Basics installieren ####
apt-get update
apt-get install git dialog
while true; do
#### Die Variable "choice" wird definiert ####
choice=`dialog --menu \
	"Auswahl" 0 0 0 \
	"Ubuntu Systemupdate" "" \
	"Installation von tm-linux-server-installhelper" "" \
	"Installation von TM Linux Server" ""\
	"Vollständiges Entfernen von TM Linux Server" "" \
	"Einrichtung von Samba" "" \
	"Einrichtung von iptables (Firewall)" "" \
	"Dieses Menü beenden" "" 3>&1 1>&2 2>&3`
#	dialog --clear
# 	dialog --yesno "Bestätigen Sie Ihre Auswahl: $choice" 0 0 
#	dialog --clear
#	clear

#### Weiterverarbeitung der Variablen "choice" ####
case "$choice" in 

   "Ubuntu Systemupdate")
        dialog --clear
	apt-get update
	apt-get upgrade
	apt-get dist-upgrade
	apt-get autoremove
	./install_tmlinuxserver.sh
   ;;
   
   "Installation von tm-linux-server-installhelper")
        dialog --clear
	   if [ -d ~/tm-linux-server-scripte ]
	      then
	         dialog --infobox "Der Installationsordner für die Scripte ist bereits vorhanden... Beginne mit dem synchronisieren" 5 40
		 sleep 5s
		 dialog --clear
		 cd ~/tm-linux-server-scripte
		 git clone git://github.com/elvito/tm-linux-server-installhelper.git .
		 ./install_tmlinuxserver.sh
	      else
		 dialog --infobox "Der Installationsordner für die Scripte wird neu angelegt, beginne in 5 Sekunden mit dem synchronisieren" 5 40
		 sleep 5s
		 dialog --clear
		 dialog --msgbox "Die Scripte werden unter ~/tm-linux-server-scripte/ gespeichert"
		 mkdir ~/tm-linux-server-scripte
		 cd ~/tm-linux-server-scripte
		 git clone git://github.com/elvito/tm-linux-server-installhelper.git .
		 dialog --msgbox "Die Scripte wurden erfolgreich im Ordner ~/tm-linux-server-scripte/ installiert :)" 
		 ./install_tmlinuxserver.sh
	    fi
   ;;
   
   "Installation von TM Linux Server")
	dialog --clear
	cd ~/tm-linux-server-scripte
	./tm-linux-server-vorbereitungsscript.sh
	dialog --msgbox "Der TM Linux Server wurde installiert :)" 5 40
	dialog --infobox "Überprüfung ob der FastObjectServer läuft beginnt in 5 Sekunden" 5 40
	sleep 5s
	dialog --clear
	clear
	/etc/init.d/poet status
	echo -e "\n\nSie sollten eine PID und \"running\" sehen\nBitte eine beliebige Taste drücken"
        read -sn1	
	dialog --msgbox "Der TM Linux Server wurde installiert :)" 5 40
   ;;
   
   "Vollständiges Entfernen von TM Linux Server")
	/opt/turbomed/TM_setup -rm
	#rm -f /opt/FastObject* 
	dialog --infobox "Löschen von TM Linux Server abgeschlossen" 5 40
	dialog --clear
   ;;
   
   "Einrichtung von Samba")
	if [ -d ~/tm-linux-server-scripte/ ]
	     then
	        dialog --msgbox "Installiere die angepasste smb.conf und starte anschließend Samba neu" 5 40
	        sleep 5s
                cp -b ~/tm-linux-server-scripte/smb.conf /etc/samba/
                chmod 644 /etc/samba/smb.conf
                service samba restart
	        dialog --infobox "Einrichtung des angepassten smb.conf abgeschlossen, Samba wurde neu gestartet" 5 40
	        dialog --clear
	      else 	
		dialog --msgbox "Installieren Sie zuerst tm-linux-server-installhelper"
		dialog --clear
	fi
   ;;
			
   "Einrichtung von iptables (Firewall)")
      dialog --msgbox "Diese Option ist noch nicht implementiert"
#      dialog --clear
   ;;
   
   "Dieses Menü beenden")
      exit 0
   ;;
   
   *)
      exit 1
   ;;
   
esac
done
