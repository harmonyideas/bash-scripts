#!/bin/bash

apache_log_dir='/var/log/apache2'
combined_log_files='goaccess_tmp.log'
logfile_name='access.log'

# find and combine all log files including ones compressed by gzip
find "$apache_log_dir"/"$logfile_name"* -type f | xargs less  > $combined_log_files

if [ $? -eq 0 ]
then
    goaccess -f $combined_log_files
    rm $combined_log_files
fi

