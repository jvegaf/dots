# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

#!/usr/bin/env zsh
# Uncomment for debuf with `zprof`
# zmodload zsh/zprof

# ZSH Ops
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FCNTL_LOCK
setopt +o nomatch
# setopt autopushd

# Start zim
source "$ZIM_HOME/init.zsh"
# source "$DOTFILES_PATH/shell/zsh/sudo.plugin.zsh"

# Async mode for autocompletion
ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_HIGHLIGHT_MAXLENGTH=300

source "$DOTFILES_PATH/shell/init.sh"

fpath=("$DOTFILES_PATH/shell/zsh/themes" "$DOTFILES_PATH/shell/zsh/completions" "$DOTLY_PATH/shell/zsh/themes" "$DOTLY_PATH/shell/zsh/completions" $fpath)

autoload -Uz promptinit && promptinit
prompt ${DOTLY_THEME:-codely}

source "$DOTLY_PATH/shell/zsh/bindings/dot.zsh"
source "$DOTLY_PATH/shell/zsh/bindings/reverse_search.zsh"
source "$DOTFILES_PATH/shell/zsh/key-bindings.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize

# bindkey "^[[1;3C" forward-word
# bindkey "^[[1;3D" backward-word

# ctrl+backspace: delete word before
bindkey '^H' backward-kill-word
# ctrl+delete: delete word after
bindkey "\e[3;5~" kill-word

# Disable the capslock key and map it to escape
#setxkbmap -option caps:backspace
# eval "$(zellij setup --generate-auto-start zsh)"

eval "$(mise activate zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/th3g3ntl3man/.lmstudio/bin"



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# bun completions
# [ -s "/home/th3g3ntl3man/.bun/_bun" ] && source "/home/th3g3ntl3man/.bun/_bun"

# # bun
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/home/th3g3ntl3man/.opencode/bin:$PATH

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code-insiders --locate-shell-integration-path zsh)"
