#!/bin/sh

run() {
  if ! pgrep -f "$1"; then
    "$@" &
  fi
}

run "picom"
run "feh" --bg-scale ~/.wallpapers/bg_1.jpeg
