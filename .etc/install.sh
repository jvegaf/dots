#!/bin/bash
# Make an ascii art to welcome the user to the script
echo "###############################################################################################################"
echo "Welcome to the Garuda Sway Config installation script"
echo "This script will install all the dependencies required and copy the files from garuda-sway-config to ~/.config"
echo "Please make sure you have an active internet connection before running this script"
echo "Press Ctrl+C to exit the script"
echo "Press Enter to continue"
echo "###############################################################################################################"
read

# Get this script directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# Get distro name
distro=$(cat /etc/os-release | grep -w "NAME" | cut -d "=" -f2 | tr -d '"')

# Ask the user if they want to update the system
echo "It is recommended to update your system first. Do you want to update the system? (y/n)"
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
  # If the distro is Garuda Linux, update the system using update command, else use pacman
  echo "Updating system"
  if [ "$distro" == "Garuda Linux" ]; then
    echo "Detected Garuda Linux, updating system..."
    update
  else
    echo "Not Garuda Linux, updating system using pacman..."
    sudo pacman -Syu --noconfirm
  fi
else
  echo "Skipping system update..."
fi

echo "Installing paru"
# Install paru
sudo pacman -S paru --noconfirm
echo "paru installed successfully"

# Function to check if a package is installed, if not, install it using paru
function install {
  if ! pacman -Qi "$1" &>/dev/null; then
    echo "Installing $1..."
    paru -S "$1" --noconfirm
  else
    echo "$1 is already installed. Skipping..."
  fi
}

# Add chaotic AUR keys and repository if not added, else skip
echo "Adding chaotic AUR keys and repository"
if ! pacman-key --list-keys chaotic-aur &>/dev/null; then
  echo "Adding chaotic AUR keys and repository"
  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  echo "Chaotic AUR keys added successfully"
else
  echo "Chaotic AUR keys and repository already added. Skipping..."
fi

# Add chaotic AUR
if ! grep -q "^\[chaotic-aur\]" /etc/pacman.conf; then
  echo "[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist" | sudo tee -a /etc/pacman.conf
  sudo pacman -Sy
  echo "Chaotic AUR repository added/updated successfully"
fi

# Install dependencies using the install function
# Make an array of all the dependencies (swaylock-effects rofi-lbonn-wayland waybar-git neofetch cava foot hyprland-git mpd mpc sweet-cursor-theme-git ttf-font-awesome nerd-fonts hyprpicker pipewire wireplumber fish)
dependencies=(

  1password

  github-cli

  qbitorrent
  blueberry
  bluez
  bluez-utils
  brightnessctl
  btop
  cava-git
  dart-sass
  eza
  fastfetch
  fd
  fish
  foot
  fzf
  git-delta
  git-lfs
  gnome-bluetooth-3.0
  gnome-keyring
  gpu-screen-recorder
  grimblast
  hyprpicker
  kitty
  localsend
  matugen
  moc-pulse
  most
  mpc
  mpd
  neovim
  nerd-fonts
  networkmanager
  nwg-look
  orca-slicer-bin
  pavucontrol
  pipewire
  python-pip
  python-pipx
  python-pynvim
  qt5ct
  qt6ct
  ripgrep
  rose-pine-cursor
  rose-pine-hyprcursor
  rustup
  sad
  speedtest-cli
  stow
  sublime-text-4
  swww
  tmux
  thunar
  thunar-volman
  thunar-vcs-plugin
  thunar-archive-plugin
  thunar-media-tags-plugin
  ttf-font-awesome
  unarchiver
  visual-studio-code-insiders-bin
  vlc
  wireplumber
  wl-clipboard
  wofi-emoji
  yad
  yt-dlp
  unrar
  uv
  mise
  starship
  yazi
  zoxide
  zsh
)

important_dependencies=(
  rofi-wayland
  hyprland
  waybar
  hyprlock
  ags-hyprpanel-git
)

echo "Installing dependencies"
# Loop through the array and install all the dependencies
for i in "${dependencies[@]}"; do
  install "$i"
done

curl -fsSL https://bun.sh/install | bash &&
  ln -s "$HOME"/.bun/bin/bun /usr/local/bin/bun

echo "Dependencies installed successfully"

echo "Installing important dependencies"
echo "You may be asked to replace some packages. Press y to replace them"
# Loop through the array and install all the dependencies
for i in "${important_dependencies[@]}"; do
  paru -S "$i"
done
echo "Important Dependencies installed successfully"

# Ask if the user wants to reboot the system now or not
echo "Do you want to reboot the system now? (y/n)"
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
  echo "Installation completed successfully. Rebooting in 5 seconds..."
  # Wait for 2s before rebooting
  sleep 5
  sudo reboot now
else
  echo "Installation completed successfully. Please reboot your system to apply the changes."
fi
