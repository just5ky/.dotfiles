#!/bin/bash
# Restore Omarchy user config from this backup onto a fresh Omarchy install.
# Safe to re-run: copies (never deletes), backs up anything it would overwrite.
set -euo pipefail

src="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.config"
dest="$HOME/.config"
stamp="$(date +%s)"

find "$src" -mindepth 1 -maxdepth 1 -printf '%f\n' | while read -r entry; do
  if [ -e "$dest/$entry" ] && [ ! -L "$dest/$entry" ]; then
    mv "$dest/$entry" "$dest/$entry.bak.$stamp"
    echo "backed up existing ~/.config/$entry -> $entry.bak.$stamp"
  fi
  cp -a "$src/$entry" "$dest/$entry"
  echo "restored ~/.config/$entry"
done

echo
echo "Done. Re-select your theme to relink current/background:"
echo "  omarchy theme set \"$(cat "$(dirname "$src")/THEME")\""
echo "Then restart the shell: omarchy restart shell"
