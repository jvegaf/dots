#!/bin/env bash

set -eu pipefail

paru -S --needed --noconfirm - < common.pkgs.txt

paru -S --needed --noconfirm - < apps.pkgs.txt

exit 0
