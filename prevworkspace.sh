#!/bin/bash

#Goes to previous workspace
CURRENTWS=`wmctrl -d | sed -n '/^[[:digit:]]  \*/{=;q;}' | xargs expr -1 +`
MAXWS=`wmctrl -d | wc -l | xargs expr -1 +`

if [ $CURRENTWS -gt 0 ]; then
	NEXTWS=$((CURRENTWS-1))
	wmctrl -s $NEXTWS
else
	wmctrl -s $MAXWS
fi
