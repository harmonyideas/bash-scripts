#!/bin/bash

FILELIST=`find ./ -maxdepth 1 -type f`
PS3="Select file to view: "

select FILENAME in $FILELIST "Exit Program"; 
do
    if  [ ! "$FILENAME" ]
    then
	echo "No file found, please select a valid option "
        continue
    fi
    	
    case $FILENAME in
        "Exit Program") break ;;
        *) less $FILENAME ;;
    esac
done
