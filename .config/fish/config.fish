## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
# set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx MANPAGER most
set -gx QT_QPA_PLATFORM xcb

## Export variable need for qt-theme
if type qtile >>/dev/null 2>&1
    set -x QT_QPA_PLATFORMTHEME qt5ct
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end

## Starship prompt
# if status --is-interactive
#    source ("/usr/bin/starship" init fish --print-full-init | psub)
# end

## Advanced command-not-found hook
# source /usr/share/doc/find-the-command/ftc.fish

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]

    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with exa
# alias ll='exa -al --color=always --group-directories-first --icons' # preferred listing
# alias la='exa -a --color=always --group-directories-first --icons' # all files and dirs
# alias l='exa -l --color=always --group-directories-first --icons' # long format
# alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
# alias l.='exa -ald --color=always --group-directories-first --icons .*' # show only dotfiles
alias ip='ip -color'
alias r='ranger'
alias bt='btop'

alias nvdprf='nvidia-settings -a "[gpu:0]/GpuPowerMizerMode=2"'

# Replace some more things with better alternatives
alias cat='bat --style header --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
# alias upd='/usr/bin/garuda-update'
# alias ..='cd ..'
# alias ...='cd ../..'
# alias ....='cd ../../..'
# alias .....='cd ../../../..'
# alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'
alias hw='hwinfo --short' # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages

# Get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# Help people new to Arch
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ls="eza -lh --group-directories-first --icons=auto"
alias l="ls"
alias ll="ls -a"
alias lt='eza --tree --level=2 --long --icons --git'
alias llt='lt -a'
alias ff='fzf --preview '\''bat --style=numbers --color=always {}'\'''
alias ~="cd ~"
alias cdc="cd ~/Code"
alias doc="cd ~/Documents"
alias dw="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias du="du -hd 1"
alias dots='cd $DOTFILES_DIR'
alias logout="gnome-session-quit --logout"
alias nvcfg="cd ~/.config/nvim"
alias vimcfg="vim ~/.vimrc"
alias r="yazi"
alias paru="paru --bottomup"
alias edalias='nvim $HOME/.config/fish/config.fish'
alias dfscripts='cd $HOME/.local/bin'
# alias ubscripts="cd $DOTFILES_PATH/os/linux/packages/xBuntu"
# alias alscripts="cd $DOTFILES_PATH/os/linux/packages/arch"
alias run="./run"
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
alias open='xdg-open'
alias zj='zellij'
alias fks='flatpak search'
alias fki='flatpak install'
alias sns='snap search'
alias sni='snap install'

# Security
alias checkrootkits="sudo rkhunter --update; sudo rkhunter --propupd; sudo rkhunter --check"
alias checkvirus="clamscan --recursive=yes --infected /home"
alias updateantivirus="sudo freshclam"

# Git
alias g="lazygit"
alias gaa="git add -A"
alias gb="git branch"
alias gba="git branch --all"
# alias gc='$DOTLY_PATH/bin/dot git commit'
alias gcl="git clone"
alias gca="git add --all && git commit --amend --no-edit"
alias gcm="git commit -m"
alias gco="git checkout"
# alias gd='$DOTLY_PATH/bin/dot git pretty-diff'
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
# alias gl='$DOTLY_PATH/bin/dot git pretty-log'
alias gsw="git switch"

alias grc="gh repo clone"

# Copilot
alias copl="copilot"
alias cops="gh copilot suggest"
alias cope="gh copilot explain"
alias copt="gh extensions install github/gh-copilot"

# flatpak
alias fps="flatpak search"
alias fpi="flatpak install"

# Arch
alias yau="yay -Syyu"
alias pau="sudo pacman -Syyu"
alias mirrors-rank="sudo reflector --verbose --latest 5 --country 'Sweden' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"

# Ubuntu
alias sai="sudo apt install"
alias aps="apt search"
alias apu="sudo apt update && sudo apt upgrade -y"

# WebDev
alias nom='npm'
alias nim='npm'

alias ns='npm start'
alias ys='yarn start'

# Utils
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg" # Arch
alias rmd='rm -rf'
alias sb="/bin/subl"
alias v='nvim'
alias b='bat'
alias k='kill -9'
alias grep='grep --color=auto'
# alias idea='intellij-idea-ultimate-edition'
alias idea='intellij-idea-ultimate'
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias cin='(code-insiders $PWD &>/dev/null &)'
alias v.='(nvim $PWD &>/dev/null &)'
alias o.='(dolphin $PWD &>/dev/null &)'
alias py='python'
alias py3='python3'
alias ffet='fastfetch'
alias i3cfg='nvim $HOME/.config/i3/config'
alias swcfg='nvim $HOME/.config/sway/config.d/application_defaults'
alias hycfg='nvim $HOME/.config/hypr/bindings.conf'

alias perfmode='cpumode performance'
alias savemode='cpumode powersave'
alias schedmode='cpumode schedutil'
alias currmode='cpumode current'

alias winreb='sudo grub-reboot 4 && sudo reboot'
alias sysd='sudo systemd-manager-tui'

# WSL
alias expl='/mnt/c/Windows/explorer.exe'
alias winyank='/mnt/c/Users/josev/scoop/shims/win32yank.exe'

#VPN
alias vpnup='sudo wg-quick up wg0'
alias vpndown='sudo wg-quick down wg0'
alias vpnstatus='sudo systemctl status wg-quick@wg0'
# status vpn tunnel sudo wg

## UV
alias pyinst='uv python install' # list python versions to install (e.g. uv python install 3.11 3.12)
alias ppi='uv pip install'
alias ppir='uv pip install -r requirements.txt'
alias ppu='uv pip uninstall'
alias ppur='uv pip uninstall -r requirements.txt'
alias ppf='uv pip freeze'
alias ppfr='uv pip freeze > requirements.txt'
alias pvc='uv venv' # Create local environment (pass '--python 3.12' for specific python version)
alias pva='source ./.venv/bin/activate'
alias pvd='deactivate' # Deactivate python environment

alias dku='docker compose up -d'
alias dkd='docker compose down'
alias lzd='lazydocker'

## Run fastfetch if session is interactive
# if status --is-interactive && type -q fastfetch
#     fastfetch
# end

function fish_greeting
    clear
    fastfetch
end

function fishfetch
    clear
    fastfetch
end

mise activate fish | source

oh-my-posh init fish --config wopian | source

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/th3g3ntl3man/.lmstudio/bin
# End of LM Studio CLI section
