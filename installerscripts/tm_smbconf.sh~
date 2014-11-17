#!/bin/bash
#### wird automatisch aufgerufen von install_tmlinuxserver.sh
#### Dieses Script nur manuell aufrufen wenn Sie wissen was Sie tun!

if [ -d ~/tm-linux-server-scripte/ ]
	then
		$DIALOG --msgbox "Installiere die angepasste smb.conf und starte anschließend Samba neu" 0 0
		$DIALOG --clear
		clear
		cp -b ~/tm-linux-server-scripte/conf/smb.conf /etc/samba/
		chmod 644 /etc/samba/smb.conf
		$DIALOG --msgbox "Überprüfen Sie die Ausgabe von testparm" 0 0
		$DIALOG --clear
		clear		
		testparm
		echo "Eine beliebige Taste drücken um fortzufahren"
		read -sn1
		$DIALOG --msgbox "Melden Sie sich bei Fehlermeldungen mit der exakten Fehlerausgabe im Forum" 0 0
		service samba restart
		$DIALOG --infobox "Einrichtung des angepassten smb.conf abgeschlossen, Samba wurde neu gestartet" 0 0
		$DIALOG --clear
		clear
	else
		$DIALOG --msgbox "Installieren Sie zuerst tm-linux-server-installhelper" 0 0
		$DIALOG --clear
		clear
fi
exit 0
