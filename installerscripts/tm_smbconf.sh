#!/bin/bash
#### wird automatisch aufgerufen von install_tmlinuxserver.sh
#### Dieses Script nur manuell aufrufen wenn Sie wissen was Sie tun!

DIALOG=dialog
IP="$(ifconfig  | grep 'inet Adresse:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')"

#### Beginn der Schleife ####
while true; do

#### Die Variable "choice" wird definiert ####
choice=`$DIALOG --menu \
	"Auswahl" 0 0 0 \
	"smb.conf installieren" "" \
	"Samba stoppen" "" \
	"Samba starten/neustarten" "" \
	"IP Adresse anzeigen" "" \
	"Zurück zum Hauptmenü" "" 3>&1 1>&2 2>&3`
	$DIALOG --clear
	clear

#### Weiterverarbeitung der Variablen "choice" ####
case "$choice" in


	"smb.conf installieren")
	if [ -d ~/Downloads ]
		then	
			$DIALOG --msgbox "Installiere die angepasste smb.conf und starte anschließend Samba neu" 0 0
			$DIALOG --clear
			clear
			cp -b ~/tm-linux-server-installhelper/conf/smb.conf /etc/samba/
			chmod 644 /etc/samba/smb.conf
			$DIALOG --msgbox "Überprüfen Sie die Ausgabe von testparm" 0 0
			$DIALOG --clear
			clear		
			testparm
			echo "Eine beliebige Taste drücken um fortzufahren"
			read -sn1
			$DIALOG --msgbox "Melden Sie sich bei Fehlermeldungen mit der exakten Fehlerausgabe im Forum" 0 0
			$DIALOG --msgbox "Einrichtung des angepassten smb.conf abgeschlossen, starten Sie ggf. Samba neu falls Ihre Freigabe nicht verfügbar ist" 0 0
			$DIALOG --clear
			clear
		else
			$DIALOG --msgbox "Der Ordner ~/Downloads ist noch nicht vorhanden und wird jetzt angelegt" 0 0
			mkdir ~/Downloads
			$DIALOG --msgbox "Installiere die angepasste smb.conf und starte anschließend Samba neu" 0 0
			$DIALOG --clear
			clear
			cp -b ~/tm-linux-server-installhelper/conf/smb.conf /etc/samba/
			chmod 644 /etc/samba/smb.conf
			$DIALOG --msgbox "Überprüfen Sie die Ausgabe von testparm" 0 0
			$DIALOG --clear
			clear		
			testparm
			echo "Eine beliebige Taste drücken um fortzufahren"
			read -sn1
			$DIALOG --msgbox "Melden Sie sich bei Fehlermeldungen mit der exakten Fehlerausgabe im Forum" 0 0
			$DIALOG --msgbox "Einrichtung des angepassten smb.conf abgeschlossen, starten Sie ggf. Samba neu falls Ihre Freigabe nicht verfügbar ist" 0 0
			$DIALOG --clear
			clear
	fi
	;;
	
	# Samba Stop	
	"Samba stoppen")
	service smbd stop
	service nmbd stop
	;;

	# Samba Neustart	
	"Samba starten/neustarten")
	service smbd restart
	service nmbd restart
	;;

	# IP Adresse anzeigen
	"IP Adresse anzeigen")
	$DIALOG --msgbox "Ihre IP Adresse lautet: $IP" 0 0
	$DIALOG --msgbox "Um auf Ihre Sambafreigaben von einem Windowsclient aus zuzugreifen geben Sie\n"\\\\$IP" in der Adressleiste des Explorers ein" 0 0
	$DIALOG --msgbox "Sollten Sie eine VM verwenden vergessen Sie nicht das Netzwerk auf \"Netzwerkbrücke\" bzw. \"bridged\" umzustellen" 0 0
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
