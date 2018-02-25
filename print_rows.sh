#!/bin/sh

x=0
y=0

while [ $x -lt 10 ]
do
x=$(($x+1))
	while [ $y -lt $x ]
	do
	    echo -n "*"
	    y=$(($y+1))
	done
y=0
echo 
done
