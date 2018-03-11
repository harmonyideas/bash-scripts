#!/bin/bash
# A simple bash script for rdiff-backup.
# requires ssh key based authentication 
 
# Set options
VERBOSE=1 # set verbose level
COMMAND='/usr/bin/rdiff-backup' # location of rdiff-backup command
REMOTEDIR='/some/remote/folder' # directory on remote host
LOCALDIR='/some/local/folder/' # directory on local host
REMOTEHOST='remotehost' # name of remote host accessible by ssh
USER='user' # remote ssh user

if [ -x ${COMMAND} ] && [ -d ${LOCALDIR} ]
then
    (${COMMAND} --print-statistics -v${VERBOSE} ${USER}@${REMOTEHOST}::${REMOTEDIR} ${LOCALDIR})
else
    echo "Command failed to run - please check ${COMMAND} exists and ${LOCALDIR} is accessible!"
fi

# Check return value of rdiff-backup. Send error message to syslog if failed.
[ "$?" != "0" ] && logger "$0: rdiff-backup of ${REMOTEDIR} has failed!"
