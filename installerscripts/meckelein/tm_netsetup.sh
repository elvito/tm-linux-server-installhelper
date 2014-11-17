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
# Entpacken des Update für die 
# Windows Clients in den NetSetup
# OrdnerWindows Clients in den NetSetup
# Ordner im TM Verzeichnisses
#
##################################

einstellungen=${0%/*}/einstellungen

source "${einstellungen}"

if [ -d ${TM_INSTALL_PATH}/NetSetup ]; then rm -rf ${TM_INSTALL_PATH}/NetSetup/*; else mkdir ${TM_INSTALL_PATH}/NetSetup; fi
7z x -o${TM_INSTALL_PATH}/NetSetup ${DOWNLOAD_PATH}/${TM_AKTUELL_WINDOWS}
chown ${SMB_USER}:${SMB_GROUP} -R ${TM_INSTALL_PATH}/NetSetup
find ${TM_INSTALL_PATH}/NetSetup -type f -exec chmod ${SMB_CHMOD_FILE} \{\} \;
find ${TM_INSTALL_PATH}/NetSetup -type d -exec chmod ${SMB_CHMOD_DIR} \{\} \;
echo
echo "Client Update steht in NetSetup Ordner zur Verfügung und kann direkt installiert werden."
