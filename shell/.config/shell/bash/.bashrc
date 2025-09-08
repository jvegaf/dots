export DOTFILES_PATH="$HOME/.dotfiles"
export DOTLY_PATH="$DOTFILES_PATH/modules/dotly"
export DOTLY_THEME="codely"

source "$DOTFILES_PATH/shell/init.sh"

PATH=$(
    IFS=":"
    echo "${path[*]}"
)
export PATH

themes_paths=(
    "$DOTFILES_PATH/shell/bash/themes"
    "$DOTLY_PATH/shell/bash/themes"
)

for THEME_PATH in ${themes_paths[@]}; do
    THEME_PATH="${THEME_PATH}/$DOTLY_THEME.sh"
    [ -f "$THEME_PATH" ] && source "$THEME_PATH" && THEME_COMMAND="${PROMPT_COMMAND:-}" && break
done

if [[ "$(ps -p $$ -ocomm=)" =~ (bash$) ]]; then
    __right_prompt() {
        RIGHT_PROMPT=""
        [[ -n $RPS1 ]] && RIGHT_PROMPT=$RPS1 || RIGHT_PROMPT=$RPROMPT
        if [[ -n $RIGHT_PROMPT ]]; then
            n=$(($COLUMNS - ${#RIGHT_PROMPT}))
            printf "%${n}s$RIGHT_PROMPT\\r"
        fi

        if
        [[ -n "${THEME_COMMAND:-}" ]] &&
        declare -F "${THEME_COMMAND:-}" &> /dev/null
        then
            "${THEME_COMMAND:-}"
        fi
    }
    export PROMPT_COMMAND="__right_prompt"
fi

for bash_file in "$DOTLY_PATH"/shell/bash/completions/_*; do
    source "$bash_file"
done

if [ -n "$(ls -A "$DOTFILES_PATH/shell/bash/completions/")" ]; then
    for bash_file in "$DOTFILES_PATH"/shell/bash/completions/_*; do
        source "$bash_file"
    done
fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

# Adding wsl-open as a browser for Bash for Windows
if [[ $(uname -r) =~ (m|M)icrosoft ]]; then
    if [[ -z $BROWSER ]]; then
        export BROWSER=wsl-open
    else
        export BROWSER=$BROWSER:wsl-open
    fi
fi


# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"




#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/th3g3ntl3man/.lmstudio/bin"
# End of LM Studio CLI section

eval "$(/home/th3g3ntl3man/.local/bin/mise activate bash)"
