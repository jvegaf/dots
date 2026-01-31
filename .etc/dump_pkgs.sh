#!/usr/bin/env bash
# Guarda listas de paquetes instalados: pacman (repos) y AUR (foreign)
# Uso: ./list-packages.sh [SALIDA_DIR]
# Por defecto guarda en el directorio actual.

set -euo pipefail

OUT_DIR=${1:-.}
mkdir -p "$OUT_DIR"

# Solicitar nombre base para los archivos
read -r -p "Introduce un nombre: " NAME
NAME=${NAME:-paquetes}

# Paquetes instalados explícitamente desde repos oficiales
PACMAN_FILE="$OUT_DIR/${NAME}_pkgs.txt"
# Paquetes instalados que no pertenecen a los repos (AUR/foreign)
AUR_FILE="$OUT_DIR/${NAME}_aur_pkgs.txt"
# Detectar si pacman está disponible
if ! command -v pacman >/dev/null 2>&1; then
  echo "Error: pacman no está disponible en este sistema." >&2
  exit 1
fi

# Lista de pacman: explícitos de repos (excluye dependencias automáticas)
pacman -Qqe | sort -u > "$PACMAN_FILE"

# Lista de AUR/foreign: paquetes no pertenecientes a repos oficiales
pacman -Qm | awk '{print $1}' | sort -u > "$AUR_FILE"

# Resumen
echo "Guardado: $PACMAN_FILE ($(wc -l < "$PACMAN_FILE") paquetes)"
echo "Guardado: $AUR_FILE ($(wc -l < "$AUR_FILE") paquetes)"
