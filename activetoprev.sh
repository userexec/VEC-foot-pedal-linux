#!/bin/bash
CURRENTWS=`wmctrl -d | sed -n '/^[[:digit:]]  \*/{=;q;}' | xargs expr -1 +`
MAXWS=`wmctrl -d | wc -l | xargs expr -1 +`

if [ $CURRENTWS -gt 0 ]; then
	PREVWS=$((CURRENTWS-1))
	wmctrl -r :ACTIVE: -t $PREVWS
	wmctrl -s $PREVWS
else
	wmctrl -r :ACTIVE: -t $MAXWS
	wmctrl -s $MAXWS
fi
