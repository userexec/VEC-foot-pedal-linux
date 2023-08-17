#!/bin/bash

OVERVIEWACTIVE=`dbus-send --session --dest=org.gnome.Shell --print-reply /org/gnome/Shell org.freedesktop.DBus.Properties.Get string:org.gnome.Shell string:OverviewActive | tail -n 1 | sed 's/   variant       boolean //'`

if [ $OVERVIEWACTIVE = "false" ]; then
	dbus-send --session --dest=org.gnome.Shell --type=method_call /org/gnome/Shell org.freedesktop.DBus.Properties.Set string:org.gnome.Shell string:OverviewActive variant:boolean:true
else 
	dbus-send --session --dest=org.gnome.Shell --type=method_call /org/gnome/Shell org.freedesktop.DBus.Properties.Set string:org.gnome.Shell string:OverviewActive variant:boolean:false
fi
