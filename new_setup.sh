#!/usr/bin/env bash
set -euo pipefail

# VARIABLES GLOBALES
USER_HOME="/home/$USER"
OPT_USER="/opt/$USER"
TMP_PARU="/tmp/paru"

# FUNCIONES DE MANEJO DE ERRORES
error_exit() {
  echo "Error en la línea $1: $2"
  exit 1
}
trap 'error_exit $LINENO "$BASH_COMMAND"' ERR

# COMPROBAR DEPENDENCIAS
for dep in gum git curl; do
  if ! command -v "$dep" &>/dev/null; then
    echo "Instalando dependencia: $dep"
    sudo pacman -Syu --needed --noconfirm "$dep"
  fi
done

# INSTALAR PARU SI NO EXISTE
if ! command -v paru &>/dev/null; then
  echo "Instalando paru (AUR Helper)..."
  sudo pacman -Syu --needed --noconfirm base-devel
  git clone https://aur.archlinux.org/paru.git "$TMP_PARU"
  cd "$TMP_PARU" || exit
  makepkg -si --needed --noconfirm
  cd - || exit
  rm -rf "$TMP_PARU"
fi

# FUNCION PARA INSTALAR PAQUETES
install_packages() {
  local pkgs=("$@")
  for pkg in "${pkgs[@]}"; do
    paru -S --needed --noconfirm "$pkg" || echo "Error instalando $pkg, continuando..."
  done
}

function install {
  if ! pacman -Qi "$1" &>/dev/null; then
    echo "Installing $1..."
    paru -S "$1" --noconfirm
  else
    echo "$1 is already installed. Skipping..."
  fi
}

install_docker() {
  paru -S --needed --noconfirm docker docker-compose docker-buildx

  sudo systemctl start docker
  sudo systemctl enable docker
  sudo usermod -aG docker "$USER"
  sudo groupadd dialout
  sudo usermod -aG dialout "$USER"

  #docker-clean
  curl -s https://raw.githubusercontent.com/ZZROTDesign/docker-clean/v2.0.4/docker-clean |
    sudo tee /usr/local/bin/docker-clean >/dev/null &&
    sudo chmod +x /usr/local/bin/docker-clean
}

# ARRAYS DE PAQUETES (revisar duplicados antes)
packages_common_utils=(
  7zip
  acpi
  adw-gtk-theme
  alsa-utils
  archlinux-xdg-menu
  ark
  bat
  bat-extras
  bibata-cursor-theme
  bind
  blueman
  bluez
  bluez-utils
  brightnessctl
  btop
  cava
  cmake
  cpio
  cpupower
  curl
  dkms
  downgrade
  eww
  eza
  fastfetch
  foot
  fzf
  git
  git-lfs
  git-delta
  github-cli
  glibc
  gnome-keyring
  go
  gtk4
  gvfs
  gvfs-mtp
  gvfs-smb
  gwenview
  kitty
  lazygit
  less
  lm_sensors
  lib32-pipewire
  libnotify
  luarocks
  man-db
  man-pages
  matugen
  meson
  mise
  mlocate
  ncdu
  neofetch
  net-tools
  networkmanager
  network-manager-applet
  networkmanager-openvpn
  ntfs-3g
  nwg-look
  openssh
  os-prober
  pacman-contrib
  pavucontrol
  pipewire
  pipewire-alsa
  pipewire-audio
  pipewire-pulse
  pkgconf-pkg-config
  pkgfile
  playerctl
  python-gobject
  python-pip
  python-pipx
  python-pynvim
  python-pywalfox
  python-kikit
  qt5ct
  qt6ct
  reflector
  rofi
  ripgrep
  rsync
  sad
  sshfs
  sddm
  sof-firmware
  starship
  stow
  superfile
  tealdeer
  tela-circle-icon-theme-dracula
  tmux
  unarchiver
  unrar
  unzip
  uv
  wallust
  wget
  wireguard-tools
  wireplumber
  yt-dlp
  zip
  zoxide
  zsh
  zstd
)

packages_common_wayland=(
  copyq
  egl-wayland
  gpu-screen-recorder
  grimblast
  mako
  qt5-wayland
  qt6-wayland
  rofi-wayland
  swww
  waybar
  wl-clipboard
  wlogout
  wlr-randr
)

packages_hyprland=(
  ags-hyprpanel-git
  hyprland
  hyprutils
  hyprpicker
  hyprpolkitagent
  hyprshot
  xdg-desktop-portal-hyprland
  hyprlock
  pyprland
  hypridle
  uwsm
  gtk-engine-murrine
  qt6-5compat
  quickshell
  aylurs-gtk-shell-git
)

packages_niri=(
  niri
  xwayland-satellite
  xdg-desktop-portal-gnome
  hyprlock
)

packages_apps=(
  1password
  blueberry
  filelight
  firefox
  foliate
  ghostty
  gnome-disk-utility
  imagemagick
  lazydocker
  lazygit
  localsend
  moc-pulse
  mpc
  mpd
  mpv
  neovim
  nomacs
  okular
  orca-slicer-bin
  platformio-core
  platformio-core-udev
  qalculate-gtk
  qbittorrent
  quickshell
  qt5ct-kde
  qt6ct-kde
  rmpc
  rose-pine-cursor
  rose-pine-hyprcursor
  rustdesk-bin
  telegram-desktop
  shortwave
  sublime-text-4
  superfile
  thunar
  thunar-volman
  thunar-vcs-plugin
  thunar-archive-plugin
  thunar-media-tags-plugin
  vim
  yazi
)

packages_fonts=(
  noto-fonts
  noto-fonts-emoji
  ttf-fantasque-nerd
  ttf-jetbrains-mono-nerd
  ttf-opensans
)

packages_firmware=(
  aic94xx-firmware
)

packages_nvidia=(
  nvidia-dkms
  lib32-nvidia-utils
  nvidia-utils
  nvidia-settings
  libva-nvidia-driver
)

install_window_managers() {
  echo "Instalando Hyprland y Niri..."
  install_packages "${packages_hyprland[@]}" "${packages_common_wayland[@]}" 
  # install_packages "${packages_common_wayland[@]}" "${packages_niri[@]}"
}

install_microcode() {
  install_packages intel-ucode
}

install_fonts() {
  install_packages "${packages_fonts[@]}"
}

install_nvidia_drivers() {
  install_packages "${packages_nvidia[@]}"
}

install_apps() {
  install_packages "${packages_apps[@]}"
}

# CREAR CARPETAS DE USUARIO
# mkdir -p "$USER_HOME/Code" "$USER_HOME/.local/bin"
mkdir -p "$USER_HOME/.local/bin"
sudo mkdir -p "$OPT_USER"
sudo chown -R "$USER:$USER" "$OPT_USER"

# INSTALACIONES PRINCIPALES
install_packages "${packages_common_utils[@]}"
install_window_managers
install_packages "${packages_firmware[@]}"
install_microcode
install_fonts
# install_nvidia_drivers
install_apps
install_docker

stow . --adopt
ln -s ./gitconfig ~/.gitconfig
# sudo cp 50-udisks.rules /etc/polkit-1/rules.d/

sudo usermod -aG input "$USER"
sudo usermod -aG uucp "$USER"

# CAMBIAR SHELL
sudo chsh -s /bin/zsh "$USER"
sudo chsh -s /bin/zsh root

# LOG Y SERVICIOS
echo "Habilitando servicios..."
systemctl --user enable pipewire
sudo systemctl enable bluetooth

echo "Script completado exitosamente."
