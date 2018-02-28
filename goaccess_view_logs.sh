#!/bin/bash

apache_log_dir='/var/log/apache2'
logfile_name='access.log'

zcat -f "$apache_log_dir"/"$logfile_name"* | goaccess

