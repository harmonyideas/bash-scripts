#!/bin/bash
# A simple bash script for rdiff-backup.
# requires ssh key based authentication 
 
# Set options
VERBOSE=1 # set verbose level
REMOTEDIR='/some/remote/folder' # directory on remote host
LOCALDIR='/some/local/folder/' # directory on local host
REMOTEHOST='remotehost' # name of remote host accessible by ssh
USER='user' # remote ssh user

if [ -x "/usr/bin/rdiff-backup" ] && [ -d $LOCALDIR ]
then
    $(/usr/bin/rdiff-backup -v${VERBOSE} ${USER}@${REMOTEHOST}::${REMOTEDIR} ${LOCALDIR})
    [ "$?" -gt "0" ] && logger "$0: rdiff-backup of ${REMOTEDIR} has failed!" || 
    rdiff-backup-statistics --begin-time `date '+%Y-%m-%d'` ${LOCALDIR} # Display backup stats for current day
else
    echo "Command failed to run - please check rdiff-backup exists and ${LOCALDIR} is accessible!"
fi


