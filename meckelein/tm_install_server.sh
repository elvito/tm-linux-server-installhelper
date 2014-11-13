#!/bin/bash
#
##################################
#     Install Script Turbomed    #
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
# Installation und Konfiguration
# des Turbomed Servers
# Ubuntu 14.04 LTS tested
#
##################################

einstellungen=${0%/*}/einstellungen
source "${einstellungen}"

if [ -d ${TM_INSTALL_PATH} ]; then 
  echo "Eine Installation von Turbomed wurde gefunden, Setup wird beendet"
  echo "Pfad aus Config: ${TM_INSTALL_PATH} prüfen."
  exit 1;
fi

mkdir ${TM_INSTALL_PATH}

echo
echo "Turbomed Dateien für den Linux Server entpacken"
if [ -d ${DOWNLOAD_PATH}/tm_linux ]; then rm -rf ${DOWNLOAD_PATH}/tm_linux/*; fi
unzip -q -d ${DOWNLOAD_PATH}/tm_linux ${DOWNLOAD_PATH}/${TM_AKTUELL_LINUX}
 
echo
echo "entpacken der Linux Server Dateien turbomed.zip und tm_var.zip"
echo "sowie kopieren der restlichen Dateien und erstellen von Infos"
echo "Alle Vorgänge wurden dem Update Script von Turbomed entnommen"
unzip -q -d ${TM_INSTALL_PATH} -o ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/archive/turbomed.zip # vorhandene überschreiben
unzip -q -d ${TM_INSTALL_PATH} -n ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/archive/tm-var.zip # vorhandene beibehalten
mkdir ${TM_INSTALL_PATH}/linux
mkdir ${TM_INSTALL_PATH}/linux/bin
mkdir ${TM_INSTALL_PATH}/linux/config
mkdir ${TM_INSTALL_PATH}/linux/text
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/TurboMed/* ${TM_INSTALL_PATH}/
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/bin/* ${TM_INSTALL_PATH}/linux/bin/
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/config/* ${TM_INSTALL_PATH}/linux/config/
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/text/* ${TM_INSTALL_PATH}/linux/text/
cp -Rf ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/poet/poetd ${TM_INSTALL_PATH}/linux/bin
echo " Ver : TM_setup 0.4.0" > ${TM_INSTALL_PATH}/linux/text/TM_setup_ver
echo "20111213" > ${TM_INSTALL_PATH}/linux/text/TM_setup_date
date > ${TM_INSTALL_PATH}/linux/text/install_date

# Installation der Pakete für den FastObjects Server
echo "Pakete für den FastObjects Server werden installiert."
for datei in $(ls ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/archive/*.deb); do
  dpkg -i ${datei}
done

# kopieren des TM Plugin für den FOS
cp -f ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/archive/libFO110Ftp90.so ${FO_INSTALL_PATH}/runtime/lib
# kopieren der Lizenzdatei der Praxis in den FOS Ordner
cp -f ${DOWNLOAD_PATH}/tm_linux/TMWin/linux/config/license ${FO_INSTALL_PATH}/runtime/lib

# Erstellen und konfigurieren der ptserver.cfg
echo
echo "Einstellungen für FOS erstellen und kopieren"
if [ -f ${PTSERV} ]; then rm ${PTSERV}; fi

while read; do
  eval echo "$REPLY" >> ${PTSERV}
done < vorlagen/ptserver.vorlage

# Erstellen und konfigurieren des Startscript
echo
echo "Runlevel Script erstellen und in /etc/init.d einbinden"
cp -f vorlagen/poetd.vorlage /etc/init.d/poetd
ln -s ${TM_INSTALL_PATH}/linux/config/ptserver.cfg /opt/FastObjects_t7_11.0/ptserver.cfg
update-rc.d poetd defaults

# Zugriffsrechte und User/Group setzen
echo
echo "Zugriffsrechte und User/Group setzen"
chown ${SMB_USER}:${SMB_GROUP} -R ${TM_INSTALL_PATH}
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

