# Omarchy config backup

Live `~/.config` state for [Omarchy](https://omarchy.org/) (Arch + Hyprland),
captured from a real install — Omarchy version `3.8.4`, theme `Tokyo Night`
(see `THEME`).

Covers every app Omarchy templates into `~/.config` (Hyprland, Waybar,
Walker, terminals, btop, fastfetch, lazygit, starship, git, fcitx5, and
`~/.config/omarchy/{hooks,themes,extensions,branding}` for custom hooks and
themes). Excludes `~/.config/chromium` — that's a browser profile, not a
setting, and not worth leaking.

## Restore

On a fresh Omarchy install:

```sh
./install.sh
```

Backs up anything it would overwrite as `<name>.bak.<timestamp>` next to it,
then copies each directory into `~/.config`. Re-run safely any time.

After restoring, re-apply the theme (relinks `~/.config/omarchy/current`)
and restart the bar/launcher:

```sh
omarchy theme set "Tokyo Night"
omarchy restart waybar
omarchy restart walker
```

## Updating this backup

```sh
apps="Typora alacritty autostart btop elephant environment.d fastfetch \
  fcitx5 fontconfig foot ghostty git hypr hyprland-preview-share-picker \
  imv kitty lazygit obsidian opencode swayosd systemd tmux uwsm walker \
  waybar wiremix xournalpp"
for d in $apps; do rsync -a --delete "$HOME/.config/$d/" ".config/$d/"; done
rsync -a "$HOME/.config/omarchy/"{hooks,themes,extensions,branding,themed} .config/omarchy/
cp "$HOME/.config"/{chromium-flags.conf,omarchy.ttf,starship.toml,xdg-terminals.list} .config/
omarchy theme current > THEME
```
