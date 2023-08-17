#!/bin/bash
CURRENTWS=`wmctrl -d | sed -n '/^[[:digit:]]  \*/{=;q;}' | xargs expr -1 +`
MAXWS=`wmctrl -d | wc -l | xargs expr -1 +`

if [ $CURRENTWS -lt $MAXWS ]; then
	NEXTWS=$((CURRENTWS+1))
	wmctrl -r :ACTIVE: -t $NEXTWS
	wmctrl -s $NEXTWS
else
	wmctrl -r :ACTIVE: -t 0
	wmctrl -s 0
fi
