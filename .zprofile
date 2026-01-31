#if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
#       Hyprland
#fi

export EDITOR='nvim'
export GIT_EDITOR="${EDITOR}"
export VISUAL="${EDITOR}"
export BROWSER='firefox'
export DOTFILES_DIR="$HOME/.dots"

export HISTORY_IGNORE="(ls|lsd|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"

# XDG vars
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_SCREENSHOTS_DIR="$HOME/Pictures"

# cleaning up the home folder
# export LESSHISTFILE="-"
# export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
# export _ZL_DATA="$XDG_CACHE_HOME/zsh/.zlua"

# colors!
# export MANPAGER="nvim +Man!"

# set the localization
# export LC_ALL=en_US.UTF-8

# lf icons
# export LF_ICONS="\
# tw=:\
# st=:\
# ow=:\
# dt=:\
# di=:\
# fi=:\
# ln=:\
# or=:\
# ex=:\
# *.c=:\
# *.cc=:\
# *.clj=:\
# *.coffee=:\
# *.cpp=:\
# *.css=:\
# *.d=:\
# *.dart=:\
# *.erl=:\
# *.exs=:\
# *.fs=:\
# *.go=:\
# *.h=:\
# *.hh=:\
# *.hpp=:\
# *.hs=:\
# *.html=:\
# *.java=:\
# *.jl=:\
# *.js=:\
# *.json=:\
# *.lua=:\
# *.md=:\
# *.php=:\
# *.pl=:\
# *.pro=:\
# *.py=:\
# *.rb=:\
# *.rs=:\
# *.scala=:\
# *.ts=:\
# *.vim=:\
# *.cmd=:\
# *.ps1=:\
# *.sh=:\
# *.bash=:\
# *.zsh=:\
# *.fish=:\
# *.tar=:\
# *.tgz=:\
# *.arc=:\
# *.arj=:\
# *.taz=:\
# *.lha=:\
# *.lz4=:\
# *.lzh=:\
# *.lzma=:\
# *.tlz=:\
# *.txz=:\
# *.tzo=:\
# *.t7z=:\
# *.zip=:\
# *.z=:\
# *.dz=:\
# *.gz=:\
# *.lrz=:\
# *.lz=:\
# *.lzo=:\
# *.xz=:\
# *.zst=:\
# *.tzst=:\
# *.bz2=:\
# *.bz=:\
# *.tbz=:\
# *.tbz2=:\
# *.tz=:\
# *.deb=:\
# *.rpm=:\
# *.jar=:\
# *.war=:\
# *.ear=:\ *.sar=:\
# *.rar=:\
# *.alz=:\
# *.ace=:\
# *.zoo=:\
# *.cpio=:\
# *.7z=:\
# *.rz=:\
# *.cab=:\
# *.wim=:\
# *.swm=:\
# *.dwm=:\
# *.esd=:\
# *.jpg=:\
# *.jpeg=:\
# *.mjpg=:\
# *.mjpeg=:\
# *.gif=:\
# *.bmp=:\
# *.pbm=:\
# *.pgm=:\
# *.ppm=:\
# *.tga=:\
# *.xbm=:\
# *.xpm=:\
# *.tif=:\
# *.tiff=:\
# *.png=:\
# *.svg=:\
# *.svgz=:\
# *.mng=:\
# *.pcx=:\
# *.mov=:\
# *.mpg=:\
# *.mpeg=:\
# *.m2v=:\
# *.mkv=:\
# *.webm=:\
# *.ogm=:\
# *.mp4=:\
# *.m4v=:\
# *.mp4v=:\
# *.vob=:\
# *.qt=:\
# *.nuv=:\
# *.wmv=:\
# *.asf=:\
# *.rm=:\
# *.rmvb=:\
# *.flc=:\
# *.avi=:\
# *.fli=:\
# *.flv=:\
# *.gl=:\
# *.dl=:\
# *.xcf=:\
# *.xwd=:\
# *.yuv=:\
# *.cgm=:\
# *.emf=:\
# *.ogv=:\
# *.ogx=:\
# *.aac=:\
# *.au=:\
# *.flac=:\
# *.m4a=:\
# *.mid=:\
# *.midi=:\
# *.mka=:\
# *.mp3=:\
# *.mpc=:\
# *.ogg=:\
# *.ra=:\
# *.wav=:\
# *.oga=:\
# *.opus=:\
# *.spx=:\
# *.xspf=:\
# *.pdf=:\
# *.nix=:\
# "

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$PATH:${$(find ~/.local/bin -maxdepth 1 -type d -printf %p:)%%:}"
fi
#
# if [ -d "$HOME/bin" ] ;
#   then PATH="$HOME/bin:$PATH"
# fi
#
if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi
#
# if [ -d "/opt/cuda/bin" ] ;
#   then PATH="/opt/cuda/bin:$PATH"
# fi
#
if [ -d "$HOME/.cargo/bin" ] ;
  then PATH="$HOME/.cargo/bin:$PATH"
fi
#
# if [ -d "$HOME/go/bin" ] ;
#   then PATH="$HOME/go/bin:$PATH"
# fi
#
if [ -d "/sbin" ] ;
  then PATH="/sbin:$PATH"
fi
#
#
# if [ -d "/var/lib/flatpak/exports/share/applications" ] ;
#   then PATH="/var/lib/flatpak/exports/share/applications:$PATH"
# fi
#


# Change directory on quitting Yazi
# Start Yazi with y, quit and cd with q, just quit with Q
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# function transcode-video-1080p() {
#   ffmpeg -i "$1" -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy ${1%.*}-1080p.mp4
# }
#
# # Transcode a video to a good-balance 4K that's great for sharing online
# function transcode-video-4K() {
#   ffmpeg -i "$1" -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k ${1%.*}-optimized.mp4
# }
#
# # Transcode any image to JPG image that's great for shrinking wallpapers
# function img2jpg() {
#   magick "$1" -quality 95 -strip ${1%.*}.jpg
# }
#
# # Transcode any image to JPG image that's great for sharing online without being too big
# function img2jpg-small() {
#   magick "$1" -resize 1080x\> -quality 95 -strip ${1%.*}.jpg
# }
#
# # Transcode any image to compressed-but-lossless PNG
# function img2png() {
#   magick "$1" -strip -define png:compression-filter=5 \
#     -define png:compression-level=9 \
#     -define png:compression-strategy=1 \
#     -define png:exclude-chunk=all \
#     "${1%.*}.png"
# }
