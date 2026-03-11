#!/bin/env bash

set -eu pipefail

sudo pacman -Syu --needed --noconfirm - < common.pkgs.txt

paru -S --needed --noconfirm - < apps.pgks.txt

exit 0
