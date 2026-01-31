#!/bin/env bash

set -eu pipefail

sudo pacman -Syu --needed --noconfirm - < common.pkgs.txt

paru --needed --noconfirm - < apps.pgks.txt

exit 0
