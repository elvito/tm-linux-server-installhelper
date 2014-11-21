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
##################################
#
# Download und Überprüfung der 
# benötigten Dateien
#
##################################

einstellungen=${0%/*}/einstellungen

source "${einstellungen}"

error="0"

if [ ! -d ${DOWNLOAD_PATH} ]; then mkdir ${DOWNLOAD_PATH}; fi

# Download der Dateien und Überprüfung der md5 Checksumme aus dem Dateinamen
for datei in ${TM_AKTUELL_WINDOWS} ${TM_AKTUELL_LINUX}; do
  echo "${datei}"
  datei_md5=$(echo "${datei}" | egrep -o "[0-9a-zA-Z]{32}")
  datei_ver=$(echo "${datei}" | egrep -o "[0-9][0-9]\.[0-9]\.[0-9]")
  if [ ! -f ${DOWNLOAD_PATH}/${datei} ]; then
    echo "|-----> downloaden"
    wget -O ${DOWNLOAD_PATH}/${datei} ${TM_SERVER}/${datei}
  else
    echo "|-----> Download übersprungen, ${datei} vorhanden"
  fi

  temp_md5=$(md5sum ${DOWNLOAD_PATH}/${datei} | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]')
  if [ "${temp_md5}" == "${datei_md5}" ]; then
    echo "|-----> md5 Checksum OK"
  else
    echo "|-----> md5 Checksum falsch"
    error="${datei} Checksum falsch"
  fi
  echo
  echo
done

if [ ! "${error}" == "0" ]; then echo "FEHLER: ${error}"; exit 1; fi
