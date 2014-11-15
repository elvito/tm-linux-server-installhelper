tm-linux-server-installhelper
=============================

Ein graphisches Installationsprogramm zur Inbetriebnahme eines Turbomedservers unter *buntu Linux

!!!!#### WICHTIG ####!!!!

Das Programm ist momentan noch weit davon entfernt einen Turbomed Server für Linux für den Produktivbetrieb zur Verfügung zu stellen. Aktuell sind keinerlei Sicherheitsfeatures implementiert. Die Benutzung eines TM Servers der mit Hilfe dieses Programms installiert wurde erfolgt auf eigene Gefahr. Es wird ebenfalls dringend davon abgeraten dieses Programm auf einem laufenden Produktivsystem einzusetzen!!! 

!!!!#### WICHTIG #####!!!!

Voraussetzungen:
- Es muss ein OS von Canonical installiert (Ubuntu, Kubuntu, LXbuntu o.ä.) sein 
- Es spielt keine Rolle ob das OS physikalisch auf dem PC installiert ist oder in einer VM läuft. Es empfiehlt sich momentan die 64bit Desktopvariante von Ubuntu zu verwenden. 
- Es muss eine gültige Lizenz für die Nutzung der AIS "Turbomed" der Firma CGM vorliegen
- Der PC auf dem der Turbomedserver installiert wird, muss während der Installation eine Verbindung ins Internet haben

Procedere:

1. Die Datei install_tmlinuxserver.sh herunterladen
2. Eine Konsole/Terminal öffnen und in den Ordner in dem install_tmlinuxserver.sh liegt wechseln (z.B. cd ~/Downloads)
3. Die Datei install_tmlinuxserver.sh mit chmod ausführbar machen, z.B. mit 
   sudo chmod 755 ~/Downloads/install_tmlinuxserver.sh
4. Von der CGM Homepage die aktuelle TM Linux Server Datei (TMLinux-Version-*.zip) herunterladen und unverändert im Ordner ~/Downloads speichern
5. Das Programm starten z.B. --> sudo ~/Downloads/install_tmlinuxserver.sh
6. Der weitere Ablauf ist selbsterklärend
7. Es empfiehlt sich nach Abschluss aller gewünschten Optionen und Beendigung des Programms den PC neu zu starten
8. Sollten Sie eine Virtualbox VM verwenden, vergessen Sie nicht nach einem Kernelupgrade die Gasterweiterungen erneut zu installieren und anschliessend die VM neu zu starten
