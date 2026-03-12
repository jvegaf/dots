#!/bin/env bash

set -eu pipefail

sudo pacman -Syu --needed --noconfirm - < common.pkgs.txt

paru -S --needed --noconfirm - < apps.pkgs.txt

exit 0
