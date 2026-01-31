bin/bash  
  
set -euo pipefail

# Define screenlock parameters 
wallpaper="$HOME/.config/niri/lock-wp.jpg"
# screenlock='swaylock -f -c 173f4f'
screenlock='swaylock -Fefkl -s fill -i ' 


 # Define config options  
   # conf="--dmenu --no-fuzzy --launch-prefix=<not set>" # for version < 1.11
  conf="--dmenu --match-mode=exact --launch-prefix=<not set>" # for version >= 1.11.0-1
  # colors="-b 173f4fee -t 21a4dfd9 -s 35b9abd9 -S ddfffdd9"
  
  # Define the menu options  
  options=("🔒\tBloquear\n""⏸\tSuspender\n""⏏\tSalir\n""🔄\tReiniciar\n""⏻\tApagar")
  
  # Show the menu and get the user's choice  
  # sel_option=$(echo -e "${options[@]}" | fuzzel $conf $colors --lines=5 --prompt "Selecciona una opción:  ")
  sel_option=$(echo -e "${options[@]}" | fuzzel $conf --lines=5 --prompt "Selecciona una opción:  ")
  

  # Check if the user selected an option  
  if [[ -n $sel_option ]]; then  
      # Extract the action part without the glyph  
      action=$(echo "$sel_option" | awk '{print $NF}')  
  
      # Ask for confirmation  
      #	confirm=$(echo -e "No - cancelar\nSí - confirmar" | fuzzel $conf $colors --lines=2 --prompt "Confirmar $action ?  " | awk '{print $1}')
    if [[ $action == "Salir" ]]; then
       fuzzel $conf --prompt-only='Pulsa Ctrl+Alt+Del para salir de Niri'
    else 
 	   confirm=$(echo -e "No - cancelar\nSí - confirmar" | fuzzel $conf --lines=2 --prompt "Confirmar $action ?  " | awk '{print $1}')
  
      # If the user confirmed, execute the selected option  
       if [[ $confirm == "Sí" ]]; then
          case $action in  
              "Bloquear")
                  #swaylock -f -c 000000
                  $screenlock $wallpaper 
                  ;;  
              "Suspender")
                  # mpc -q pause  
                  # pamixer --mute  
                  systemctl suspend  
                  ;;  
              "Salir")
                  # swaymsg exit 
                  # no equivalent command for Niri 
                  ;;  
              "Reiniciar")
                  systemctl reboot  
                  ;;  
              "Apagar")
                  systemctl poweroff  
                  ;;  
          esac  
       fi  
    fi  
  fi  
  # Exit the script  
  exit 0
