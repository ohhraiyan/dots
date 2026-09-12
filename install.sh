#!/usr/bin/env bash

set -e

# ==========================================
# Dotfiles Installer
# ==========================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.config"
CONFIG_DIR="$HOME/.config"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

configs=(
  cava
  fastfetch
  fuzzel
  kitty
  niri
  noctalia
  yazi
)

echo "╭──────────────────────────────╮"
echo "│      Dotfiles Installer      │"
echo "╰──────────────────────────────╯"
echo

# Check source directory
if [[ ! -d "$DOTFILES_DIR" ]]; then
  echo "Error: .config directory not found."
  exit 1
fi

# Create config directory
mkdir -p "$CONFIG_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

echo "Backing up existing configs..."
echo

for config in "${configs[@]}"; do
  if [[ -e "$CONFIG_DIR/$config" ]]; then
    echo "  → $config"
    mv "$CONFIG_DIR/$config" "$BACKUP_DIR/"
  fi
done

echo
echo "Installing dotfiles..."
echo

for config in "${configs[@]}"; do
  if [[ -e "$DOTFILES_DIR/$config" ]]; then
    echo "  → $config"
    cp -a "$DOTFILES_DIR/$config" "$CONFIG_DIR/"
  else
    echo "  ! $config not found, skipping"
  fi
done

echo
echo "╭──────────────────────────────╮"
echo "│       Installation done!     │"
echo "╰──────────────────────────────╯"
echo
echo "Backup: $BACKUP_DIR"
echo
echo "Installed:"
printf '  ✓ %s\n' "${configs[@]}"
echo
