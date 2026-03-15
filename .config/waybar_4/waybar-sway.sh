#!/usr/bin/env sh

# Terminate already running bar instances
killall -q waybar

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main
# waybar -c ~/.config/waybar/config-sway.jsonc -s ~/.config/waybar/style-sway.css &
# waybar -c ~/.config/waybar/mechabar/config.jsonc -s ~/.config/waybar/mechabar/style.css &
waybar -c ~/.config/waybar/mechabar/config.jsonc.mechabar -s ~/.config/waybar/mechabar/style.css.mechabar &
