#!/bin/bash
source ~/.config/i3blocks/colors.sh

mem=$(free | grep Mem: | awk '{ print $3 }')

memory=$(echo "$mem / 1024 / 1024" | bc -l)

printf " %.2f GB \n" "$memory"
printf " %.2f GB \n" "$memory"
echo "$bg"
echo "$Lblue"

