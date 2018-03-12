#!/bin/bash
# A simple bash script for rdiff-backup.
# requires ssh key based authentication 
 
# Set options
VERBOSE=1 # set verbose level
REMOTEDIR='/some/remote/folder' # directory on remote host
LOCALDIR='/some/local/folder/' # directory on local host
REMOTEHOST='remotehost' # name of remote host accessible by ssh
USER='user' # remote ssh user

if [ -x "/usr/bin/rdiff-backup"  ] && [ -d $LOCALDIR ]
then
    echo "$(/usr/bin/rdiff-backup --print-statistics -v$VERBOSE $USER@$REMOTEHOST::$REMOTEDIR $LOCALDIR)"
    # Check return value of rdiff-backup. Send error message to syslog if failed.
    [ "$?" != "0" ] && logger "$0: rdiff-backup of $REMOTEDIR has failed!"
else
    echo "Command failed to run - please check rdiff-backup exists and $LOCALDIR is accessible!"
fi

