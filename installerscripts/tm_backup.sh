#!/bin/bash

# Variable definieren
DIALOG=dialog
APTGET=apt-get

#### Einrichtung von Xubuntu und Backintime #####

# Zunächst mal sicherstellen das dkms für die Gasterweiterungen installiert ist
apt-get install dkms

# Erklärung
$DIALOG --msgbox "Für die Verwendung von Backintime als Backuplösung muss Xubuntu installiert werden.\nDie wird ca. 1,5Gigabyte zusätzlichen Speicher belegen..." 0 0

# Ein neues Menu erzeugen
#### Die Variable "choice" wird definiert ####
choice=`$DIALOG --menu \
	"Auswahl" 0 0 0 \
	"Installieren von Xubunut und Backintime" "" \
	"Zurück zum Hauptmenü" "" 3>&1 1>&2 2>&3`
	$DIALOG --clear
	clear

case "$choice" in

	# Installieren von Xubunut und Backintime
	"Installieren von Xubunut und Backintime")
	$DIALOG --clear
	clear
	$APTGET update
	$APTGET install xubuntu-desktop backintime-gnome
	$APTGET autoremove
	$DIALOG --msgbox "Nach einem Reboot steht Ihnen die graphische Oberfläche zur Verfügung" 0 0
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
