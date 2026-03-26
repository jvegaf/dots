#!/bin/env bash

set -eu pipefail

paru -S --needed --noconfirm - < latest_hypr_pkgs.txt

# paru -S --needed --noconfirm - < apps.pkgs.txt

exit 0
