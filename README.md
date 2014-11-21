tm-linux-server-installhelper
=============================

Ein graphisches Installationsprogramm zur Inbetriebnahme eines Turbomedservers unter *buntu Linux

!!!!#### WICHTIG ####!!!!

Das Programm ist momentan noch weit davon entfernt einen Turbomed Server für Linux für den Produktivbetrieb zur Verfügung zu stellen. Aktuell sind keinerlei Sicherheitsfeatures implementiert. Die Benutzung eines TM Servers der mit Hilfe dieses Programms installiert wurde erfolgt auf eigene Gefahr. Es wird ebenfalls dringend davon abgeraten dieses Programm auf einem laufenden Produktivsystem einzusetzen!!! 

Voraussetzungen:
- Es muss ein OS von Canonical installiert (Ubuntu, Kubuntu, LXbuntu o.ä.) sein 
- Es spielt keine Rolle ob das OS physikalisch auf dem PC installiert ist oder in einer VM läuft. Es empfiehlt sich momentan zu Testzwecken den TM Server in einer VM zu betreiben. 
- Es muss eine gültige Lizenz für die Nutzung der AIS "Turbomed" der Firma CGM vorliegen
- Der PC auf dem der Turbomedserver installiert wird, muss während der Installation eine Verbindung ins Internet haben

Procedere am Beispiel einer VirtualboxVM mit einem vorbereiteten Ubuntu Serverimage:
(Wenn man die Desktopvariante verwendet entfallen u.U. einige der u.g. Punkte)


1. Das Virtualboximage von folgender Adresse herunterladen --> https://drive.google.com/folderview?id=0BzJV5Qf7aCEVd2pEQUlYWXJkQ0E&usp=sharing (entpackt ca. 520MB)
2. Das Image entpacken und in Virtualbox importieren
3. Bei den Netzwerkeinstellungen in Virtualbox ggf. Adapter 1 von NAT auf Netzwerkbrücke umstellen
4. Die VM starten und sich mit dem Benutzernamen: testserver und dem paswort test anmelden
5. Den Updater ausführen mit: ./update_tm-installer-master.sh (Alternativ ./update-tm_installer-testing.sh für die aktuellste Testversion) 
6. Mit: cd ~/tm-linux-server-installhelper in das Programmverzechnis wechseln
7. Den Installer mit: sudo ./install_tmlinuxserver.sh starten
8. Nach dem Systemupdate einen Reboot durchführen (am einfachsten geht das über den Installer)
9. Nach dem Reboot erneut Punkt 4., 6. und 7. ausführen um den Installer erneut zu starten
10. Auf dem Hostrechner (ich gehe davon aus das die VM als Gast auf einem Windowsrechner (Host) läuft) die TMLinux Datei von CGM runterladen
11. Man sollte beim Host in der Netzwerkumgebung den Sambaserver sehen (falls nicht, wird auch während der Einrichtung von Samba durch den Installer weitere Hinweise gegeben)
12. Die CGM TM Datei in den freigegebenen Ordner "Downloads" kopieren
13. In der VM (Installer) den Punkt "TM Server installieren" wählen und den Bildschirmanweisungen folgen
14. Der Turbomedserver sollte nun installiert und funktionsfähig sein
