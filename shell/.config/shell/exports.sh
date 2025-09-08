# ------------------------------------------------------------------------------
# Codely theme config
# ------------------------------------------------------------------------------
export EDITOR="/usr/bin/nvim"
# export M2_HOME="$HOME/.sdkman/candidates/maven/current"
# export WINEPREFIX="$HOME/.fusion360/wineprefixes/default"
# export EDITOR="$HOME/.local/bin/lvim"
# ------------------------------------------------------------------------------
# Languages
# ------------------------------------------------------------------------------
# export GEM_HOME="$HOME/.gem"
# export GOPATH="$HOME/.go"
# export HOMEBREW_BUNDLE_FILE="$DOTFILES_PATH/os/linux/brew/Brewfile"
# ------------------------------------------------------------------------------
# Apps
# ------------------------------------------------------------------------------
# if [ "$CODELY_THEME_MODE" = "dark" ]; then
#   fzf_colors="pointer:#ebdbb2,bg+:#3c3836,fg:#ebdbb2,fg+:#fbf1c7,hl:#8ec07c,info:#928374,header:#fb4934"
# else
#   fzf_colors="pointer:#db0f35,bg+:#d6d6d6,fg:#808080,fg+:#363636,hl:#8ec07c,info:#928374,header:#fffee3"
# fi
# ------------------------------------------------------------------------------
# Browser
# ------------------------------------------------------------------------------
# if [[ $(grep microsoft /proc/version) ]]; then
# 	# echo "Bash is running on WSL"
# 	export BROWSER="wsl-open"
# 	# else
# 	# echo "Bash is running on linux"
# fi

export FZF_DEFAULT_OPTS="--color=$fzf_colors --reverse"

# ------------------------------------------------------------------------------
# Path - The higher it is, the more priority it has
# ------------------------------------------------------------------------------
export path=(
  "$HOME/.bin"
  "$HOME/.opt"
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  "/usr/local/opt/ruby/bin"
  "/usr/local/opt/python/libexec/bin"
  "/usr/local/bin"
  "/usr/local/sbin"
  "/bin"
  "/usr/bin"
  "/usr/bin/flutter/bin"
  "/usr/sbin"
  "/sbin"
  "$HOME/.local/share/JetBrains/Toolbox/scripts"
  "/snap/bin"
  "$HOME/.platformio/penv/bin"
  "/mnt/c/Windows"
  "$USERPROFILE/scoop/shims"
)
