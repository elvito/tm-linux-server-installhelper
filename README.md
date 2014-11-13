tm-linux-server-installhelper
=============================

Hilfreiche Scripte zur Installation und Inbetriebnahme eines Turbomedservers unter *buntu Linux

Voraussetzungen:
Es muss ein OS von Canonical installiert sein (Ubuntu, KDE, LXbuntu o.ä.) 
Es empfiehlt sich momentan die 64bit Desktopvariante von Ubuntu zu verwenden
Es muss eine gültige Lizenz für die Nutzung der AIS "Turbomed" der Firma CGM vorliegen

Procedere:

A) Automatisches Update von *buntu und Installation des TM Linux Server

1. Die Datei tm-linux-server-vorbereitungsscript.sh herunterladen und im Ordner ~/Downloads speichern
2. Von der CGM Homepage die aktuelle TM Linux Server Datei herunterladen und gezipped in ~/Downloads abspeichern
3. Das Vorbereitungsscript "ausführbar" machen mit: 
4. sudo chmod 755 ~/Downloads/[Name der vorhandenen TMLinux-Version-*.zip]
4. Aufruf des Scriptes mit: ~/Downloads/tm-linux-server-vorbereitungsscript.sh
5. Die auftretenden Fragen können aktuell alle mit "j" beantwortet werden

B) Konfiguration von Samba
