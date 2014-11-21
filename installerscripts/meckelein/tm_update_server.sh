#!/bin/bash
#
##################################
#     Update Script Turbomed     #
##################################
#
# Von Alexander Meckelein
#
# Version: 0.2
# Datum: 11.11.2014
#
# Jeder darf dieses Script benutzen
# und verändern, unter Hinweis auf 
# alle vorherigen Autoren.
#
##################################
#
# Update einer vorhandenen 
# Turbomed Installation
#
##################################

einstellungen=${0%/*}/einstellungen
source "${einstellungen}"

if [ ! -d ${TM_INSTALL_PATH} ]; then 
  echo "Turbomed nicht gefunden, Update abgebrochen."
  echo "Pfad aus Config: ${TM_INSTALL_PATH} prüfen."
  exit 1;
fi

if [ ! -d ${FO_INSTALL_PATH} ]; then
  echo "FastObjectsServer nicht gefunden, Update abgebrochen."
  echo "Pfad aus Config: ${FO_INSTALL_PATH} prüfen."
  exit 1;
fi

echo
echo "Turbomed Dateien für den Linux Server entpacken"
service poetd stop
if [ -d ${DOWNLOAD_PATH}/tm_linux ]; then rm -rf ${DOWNLOAD_PATH}/tm_linux/*; fi
unzip -q -d ${DOWNLOAD_PATH}/tm_linux ${DOWNLOAD_PATH}/${TM_AKTUELL_LINUX}

# Einstellungen sichern
echo
echo "Sichern der vorhandenen Einstellungen vom Turbomed."
echo "${TM_INSTALL_PATH}/linux/config/license"
echo "${TM_INSTALL_PATH}/linux/config/ptserver.cfg"
echo "${TM_INSTALL_PATH}/linux/poet/poet.conf"
if [ -d ${DOWNLOAD_PATH}/einstellungen ]; then rm -rf ${DOWNLOAD_PATH}/einstellungen/*; else mkdir ${DOWNLOAD_PATH}/einstellungen; fi
cp ${TM_INSTALL_PATH}/linux/config/license ${DOWNLOAD_PATH}/einstellungen/license
cp ${TM_INSTALL_PATH}/linux/config/ptserver.cfg ${DOWNLOAD_PATH}/einstellungen/ptserver.cfg
cp ${TM_INSTALL_PATH}/linux/bin/poet.conf ${DOWNLOAD_PATH}/einstellungen/poet.conf

# Neue Dateien entpacken und kopieren
echo
echo "entpacken der Linux Server Dateien turbomed.zip und tm_var.zip"
echo "sowie kopieren der restlichen Dateien und erstellen von Infos"
echo "Alle Vorgänge wurden dem Update Script von Turbomed entnommen"
unzip -q -d ${TM_INSTALL_PATH} -o ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/archive/turbomed.zip # vorhandene überschreiben
unzip -q -d ${TM_INSTALL_PATH} -n ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/archive/tm-var.zip # vorhandene beibehalten
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/TurboMed/* ${TM_INSTALL_PATH}/
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/bin ${TM_INSTALL_PATH}/
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/config ${TM_INSTALL_PATH}/
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/text ${TM_INSTALL_PATH}/
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/poet/* ${TM_INSTALL_PATH}/linux/bin
echo " Ver : TM_setup 0.4.0" > ${TM_INSTALL_PATH}/linux/text/TM_setup_ver
echo "20111213" > ${TM_INSTALL_PATH}/linux/text/TM_setup_date
date > ${TM_INSTALL_PATH}/linux/text/install_date
#zurück kopieren der vorab gesicherten Einstellungen
cp -Rf ${DOWNLOAD_PATH}/einstellungen/license ${TM_INSTALL_PATH}/linux/config/license
cp -Rf ${DOWNLOAD_PATH}/einstellungen/ptserver.cfg ${TM_INSTALL_PATH}/linux/config/ptserver.cfg
cp -Rf ${DOWNLOAD_PATH}/einstellungen/poet.conf ${TM_INSTALL_PATH}/linux/bin/poet.conf

# Installation der Pakete für den FastObjects Server
# aber nur wenn eine andere Version vor liegt
echo
echo "Pakete für den FastObjects Server werden installiert."
for datei in $(ls ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/archive/*.deb); do
  datei_ver=$(echo "${datei}" | egrep -o "[0-9][0-9]\.[0-9]\.[0-9]\.[0-9][0-9][0-9]-1")
  if [ ${datei_ver} != ${FO_VER} ]; then
    dpkg -i ${datei}
  fi
done

# kopieren des TM Plugin für den FOS
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/archive/libFO110Ftp90.so ${FO_INSTALL_PATH}/runtime/lib
# kopieren der Lizenzdatei der Praxis in den FOS Ordner
cp -Rf ${TM_INSTALL_PATH}/linux/config/license ${FO_INSTALL_PATH}/runtime/lib

# Zugriffsrechte und User/Group setzen
echo
echo "Zugriffsrechte und User/Group setzen"
chmod ${SMB_CHMOD_FILE} -R ${TM_INSTALL_PATH}
find ${TM_INSTALL_PATH} -type d -exec chmod ${SMB_CHMOD_DIR} \{\} \;
chmod 700 -R ${TM_INSTALL_PATH}/linux/bin
chmod 555 /etc/init.d/poetd
chmod 555 ${FO_INSTALL_PATH}/runtime/lib/libFO110Ftp90.so
chown bin:bin ${FO_INSTALL_PATH}/runtime/lib/libFO110Ftp90.so

service poetd start

echo
echo "Installation erfolgreich beendet, es sollte alles funktionieren."
echo
echo "Hoffe ich mal :)"

