#!/bin/bash

set -euo pipefail

echo "dumping packages ⚡"

pacman -Qqen >pkglist.txt
pacman -Qqem >aurpkglist.txt

echo "packages dumped ✅"

exit 0
