tm-linux-server-installhelper
=============================

Hilfreiche Scripte zur Installation und Inbetriebnahme eines Turbomedservers unter *buntu Linux

Voraussetzungen:
Es muss ein OS von Canonical installiert sein (Ubuntu, Kubuntu, LXbuntu o.ä.) 
Es empfiehlt sich momentan die 64bit Desktopvariante von Ubuntu zu verwenden
Es muss eine gültige Lizenz für die Nutzung der AIS "Turbomed" der Firma CGM vorliegen

Procedere:

A) Automatisches Update von *buntu und Installation des TM Linux Server

1. Die Datei tm-linux-server-vorbereitungsscript.sh herunterladen und im Ordner ~/Downloads speichern
2. Von der CGM Homepage die aktuelle TM Linux Server Datei herunterladen und gezipped in ~/Downloads abspeichern
3. Das Vorbereitungsscript "ausführbar" machen mit: "sudo chmod 755 ~/Downloads/[Name der vorhandenen TMLinux-Version-*.zip]"
4. Aufruf des Vorbereitungsscripts mit: ~/Downloads/tm-linux-server-vorbereitungsscript.sh
5. Die auftretenden Fragen können aktuell alle mit "j" beantwortet werden

B) Konfiguration von Samba (Die aktuelle Version der angepassten smb.conf bietet noch keinerlei Sicherheit) 

1. Machen Sie eine Sicherungskopie der ursprünglichen smb.conf --> "sudo cp /etc/samba/smb.conf /etc/samba/smb.conf.bak"
2. Überschreiben Sie die smb.conf mit der angepassten Version --> "sudo mv /[Pfad zur angepassten smb.conf]/smb.conf /etc/samba/
3. Warten Sie mindestens 60 Sekunden oder starten Sie Samba von Hand neu, um die Änderungen sofort gültig zu machen --> "sudo service smbd restart" 
