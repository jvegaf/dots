#!/bin/env bash

set -eu pipefail

sudo pacman -Syu --needed --noconfirm - <pkglist.txt

yay -Syu --needed --noconfirm - <aurpkglist.txt

exit 0
