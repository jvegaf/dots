#!/bin/env bash

set -eu pipefail

paru -S --needed --noconfirm - < lates_pkgs.txt

paru -S --needed --noconfirm - < lates_aur_pkgs.txt

exit 0
