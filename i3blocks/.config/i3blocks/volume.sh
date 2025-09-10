#!/bin/bash

source ~/.config/i3blocks/colors.sh

icon=""


vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')


vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
is_muted=$(echo $vol_info | awk '{print $3}')


if [ "$vol" -lt 30 ]; then
    icon="󰖀 "

else
    icon="󰕾 "
fi


if [ "$is_muted" == "[MUTED]" ];then 
    vol=0
    icon="󰝟 "
elif [ "$vol" -eq 0 ]; then
    vol=0
    icon="󰝟 "
fi



echo " $icon$vol% "
echo " $icon$vol% "
echo "$fg"
echo "$Nmagenta"



