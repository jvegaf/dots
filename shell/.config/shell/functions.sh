function cdd() {
  cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}

function j() {
  fname=$(declare -f -F _z)

  [ -n "$fname" ] || source "$DOTLY_PATH/modules/z/z.sh"

  _z "$1"
}

function recent_dirs() {
  # This script depends on pushd. It works better with autopush enabled in ZSH
  escaped_home=$(echo $HOME | sed 's/\//\\\//g')
  selected=$(dirs -p | sort -u | fzf)

  cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}

quote_search_terms() {
  for term in "$@"; do
    echo "\"$term\" "
  done
}

function ww() {
  xdg-open "https://www.google.com/search?q=$(quote_search_terms "$@")"
}

function www() {
  xdg-open "https://"$@""
}


