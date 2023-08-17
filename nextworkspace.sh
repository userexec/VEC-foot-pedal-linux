#!/bin/bash

#Goes to next workspace
CURRENTWS=`wmctrl -d | sed -n '/^[[:digit:]]  \*/{=;q;}' | xargs expr -1 +`
MAXWS=`wmctrl -d | wc -l | xargs expr -1 +`

if [ $CURRENTWS -lt $MAXWS ]; then
	NEXTWS=$((CURRENTWS+1))
	wmctrl -s $NEXTWS
else
	wmctrl -s 0
fi
