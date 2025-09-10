#!/bin/bash
icon=""
chargestatus=""

# bat0full=$(echo "$var / 100000" | bc)
source ~/.config/i3blocks/colors.sh

path="/sys/class/power_supply"

bat0full=$(cat "$path/BAT0/energy_full")
bat0now=$(cat "$path/BAT0/energy_now")

bat1full=$(cat "$path/BAT1/energy_full")
bat1now=$(cat "$path/BAT1/energy_now")

tmp="$bat1full + $bat0full"
totalfull=$(echo "$tmp" | bc)

tmp="$bat0now + $bat1now"
totalnow=$(echo "$tmp" | bc)

percentage=$(echo "scale=3; (($totalnow / $totalfull) * 100)" | bc)
percentage=$(echo $percentage | sed 's/\.\([0-9]\)00$/.\1/')

int_percentage=$(echo "$percentage" | awk '{print int($1+0.5)}')

bat0power=$(cat "$path/BAT0/power_now")
bat1power=$(cat "$path/BAT1/power_now")

totalpower="$bat1power+ $bat0power"
totalpower=$(echo "scale=3; (($totalpower ) / 1000000)" | bc)
totalpower=" $totalpower W"



if (( $int_percentage >= 90 )); then
    icon="󰁹"
elif (( $int_percentage >= 80 )); then
    icon="󰂂"
elif (( $int_percentage >= 70 )); then
    icon="󰂁"
elif (( $int_percentage >= 60 )); then
    icon="󰂀"
elif (( $int_percentage >= 50 )); then
    icon="󰁿"
elif (( $int_percentage >= 40 )); then
    icon="󰁾"
elif (( $int_percentage >= 30 )); then
    icon="󰁽"
elif (( $int_percentage >= 20 )); then
    chargestatus=""
    icon="󰁼"
else
    icon="󰁻"
    chargestatus=""
fi


bat0status=$(cat "$path/BAT0/status")
bat1status=$(cat "$path/BAT1/status")


if [[ $(cat "/sys/class/power_supply/AC/online") == "1" ]]; then
    if [[ $( cat "$path/BAT0/status") == "Charging" ]] || [[ $( cat "$path/BAT1/status") == "Charging" ]]; then
        chargestatus=" "
        # totalpower=""
    else 
        icon="󱟢"
        # totalpower=""
    fi

fi

echo " $chargestatus$icon $percentage%$totalpower "










