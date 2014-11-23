#!/bin/bash

# Variable definieren
DIALOG=dialog
APTGET=apt-get

#### Einrichtung von Xubuntu und Backintime #####

# Zunächst mal sicherstellen das dkms für die Gasterweiterungen installiert ist
apt-get update
apt-get install dkms

# Erklärung
$DIALOG --msgbox "Für die Verwendung von Backintime als Backuplösung muss Xubuntu installiert werden.\nDie wird ca. 1,5Gigabyte zusätzlichen Speicher belegen..." 0 0

# Ein neues Menu erzeugen
#### Die Variable "choice" wird definiert ####
choice=`$DIALOG --menu \
	"Auswahl" 0 0 0 \
	"Installieren von Xubuntu und Backintime" "" \
	"Installieren von Kubuntu und Backintime" "" \
	"Vollständiges Entfernen von Xubuntu und Backintime" "" \
	"Vollständiges Entfernen von Kubuntu und Backintime" "" \
	"Zurück zum Hauptmenü" "" 3>&1 1>&2 2>&3`
	$DIALOG --clear
	clear

case "$choice" in

	# Installieren von Xubuntu und Backintime
	"Installieren von Xubuntu und Backintime")
	$DIALOG --clear
	clear
	$APTGET update
	$APTGET install xubuntu-desktop backintime-gnome
	$APTGET autoremove
	$DIALOG --msgbox "Nach einem Reboot steht Ihnen die graphische Oberfläche zur Verfügung" 0 0
	;;
	
	# Installieren von Kubuntu und Backintime
	"Installieren von Kubuntu und Backintime")
	$DIALOG --clear
	clear
	$APTGET update
	$APTGET install kubuntu-desktop language-pack-kde-de backintime-kde
	$APTGET autoremove
	$DIALOG --msgbox "Nach einem Reboot steht Ihnen die graphische Oberfläche zur Verfügung" 0 0
	;;
	
	# Vollständiges Entfernen von Xubuntu und Backintime
	"Vollständiges Entfernen von Xubuntu und Backintime")
	$DIALOG --clear
	clear
	$APTGET upgrade
	$APTGET --purge remove backintime-gnome libgtk2.0-0 libgtk-3-common language-pack-kde-de 
	$APTGET autoremove
	$DIALOG --msgbox "Xubuntu und Backintime wurden vollständig entfernt" 0 0
	;;
	
	# Vollständiges Entfernen von Kubuntu und Backintime
	"Vollständiges Entfernen von Kubuntu und Backintime")
	$DIALOG --clear
	clear
	$APTGET upgrade
	$APTGET --purge remove backintime-kde libqtcore4 libkdecore5 kdelibs-bin
	$APTGET autoremove
	$DIALOG --msgbox "Kubuntu und Backintime wurden vollständig entfernt" 0 0
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
