#!/bin/bash

# Variable definieren
DIALOG=dialog

#### Einrichtung von iptables #####

# Zunächst mal sicherstellen das iptables installiert ist
apt-get install iptables

# Ein neues Menu erzeugen
#### Die Variable "choice" wird definiert ####
choice=`$DIALOG --menu \
	"Auswahl" 0 0 0 \
	"Installieren von arno-iptables-firewall" "" \
	"Anzeigen der Regeln von iptables" "" \
	"arno-iptables-firewall starten" "" \
	"arno-iptables-firewall stoppen" "" \
	"arno-iptables-firewall neustarten" "" \
	"arno-iptables-firewall neu konfigurieren" "" \
	"arno-iptables-firewall vollständig entfernen" "" \
	"Zurück zum Hauptmenü" "" 3>&1 1>&2 2>&3`
	$DIALOG --clear
	clear

case "$choice" in

	# Installieren von arno-iptables-firewall
	"Installieren von arno-iptables-firewall")
	apt-get install arno-iptables-firewall
	;;
	
	# Anzeigen der Regeln von iptables
	"Anzeigen der Regeln von iptables")
	dialog --clear
	clear	
	iptables -L
	echo "Bitte eine beliebige Taste drücken"
	read -sn1
	;;

	# arno-iptables-firewall starten
	"arno-iptables-firewall starten")
	service arno-iptables-firewall start
	;;

	# arno-iptables-firewall stoppen
	"arno-iptables-firewall stoppen")
	service arno-iptables-firewall stop
	;;

	# arno-iptables-firewall neustarten
	"arno-iptables-firewall neustarten")
	service arno-iptables-firewall restart
	;;

	# arno-iptables-firewall neu konfigurieren
	"arno-iptables-firewall neu konfigurieren")
	dpkg-reconfigure arno-iptables-firewall
	;;

	# arno-iptables-firewall vollständig entfernen
	"arno-iptables-firewall vollständig entfernen")
	apt-get purge arno-iptables-firewall
	;;

	# Zurück zum Hauptmenü
	"Zurück zum Hauptmenü")
	exit 0
	;;
	
	# Alle anderen Fälle
	*)
	exit 1
	;;
esac
done
