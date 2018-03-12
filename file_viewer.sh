#!/bin/bash

# Get a listing of all files in the current directory
# and put them into array FILELIST. Use sed to remove ./
# from filenames
 
filelist=(`find ./ -maxdepth 1 -type f | sed 's/\.\///g'`)

# Create prompt for user to select files and process 
# input using select statement.  Find max length of 
# array and add 1 to display choice to exit.  If no
# file is found - display error message to user
 
PS3="Select file to view or ($(expr ${#filelist[@]} + 1)) to exit: "

select filename in ${filelist[@]} "Exit Program"; 
do
    if  [ ! "$filename" ]
    then
	echo "No file found, please select a valid option "
        continue
    fi
    	
    case $filename in
        "Exit Program") break ;;
        *) less $filename ;;
    esac
done
