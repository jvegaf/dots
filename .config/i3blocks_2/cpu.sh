#!/bin/bash
source ~/.config/i3blocks/colors.sh

# Example: CPU usage percentage
CPU_USAGE=$(mpstat 1 1 | awk '/^Average:/ {usage=100-$NF} END {print int(usage) }')


# Define thresholds for changing color
THRESHOLD_HIGH=80
THRESHOLD_MEDIUM=60

bgcolor="$Lgreen"

# Set colors based on the CPU usage
if [ ${CPU_USAGE} -gt $THRESHOLD_MEDIUM ]; then
    COLOR="$Nred"  # Red for high usage
elif [ '${CPU_USAGE}' -gt $THRESHOLD_HIGH ]; then
    COLOR="$Nmagenta"  # Yellow for medium usage
else
    COLOR="$bg"  # Green for low usage
fi

# Output the block information
echo "  $CPU_USAGE% "
echo "  $CPU_USAGE% "
echo "$COLOR"
echo "$bgcolor"


