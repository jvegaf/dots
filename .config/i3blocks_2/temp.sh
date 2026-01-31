#!/bin/bash

source ~/.config/i3blocks/colors.sh

temp=$(sensors 'coretemp-*' | grep '^Package id' | awk '{ print $4 }' | grep -o '[0-9]\+' | head -n1)

if [ $temp -gt 55 ]; then
    color="$Lred"
elif [ $temp -gt 45 ]; then
    color="$Lyellow"
else
    color="$fg"
fi

echo " $temp󰔄 "
echo " $temp󰔄 "
echo "$color"
echo "$Ngreen"
