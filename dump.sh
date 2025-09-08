#!/bin/bash

set -euo pipefail

echo "dumping packages ⚡"

rm -rf pkglist.txt aurpkglist.txt

pacman -Qqen >pkglist.txt
pacman -Qqem >aurpkglist.txt

echo "packages dumped ✅"

exit 0
