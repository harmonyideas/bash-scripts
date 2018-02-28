#!/bin/bash

FILELIST=(`find ./ -maxdepth 1 -type f | sed 's/\.\///g'`)
PS3="Select file to view or ($(expr ${#FILELIST[@]} + 1)) to exit: "

select FILENAME in ${FILELIST[@]} "Exit Program"; 
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
