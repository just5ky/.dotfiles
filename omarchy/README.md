# Omarchy config backup

Live `~/.config` state for [Omarchy](https://omarchy.org/) (Arch + Hyprland),
captured from a real install — Omarchy version `4.0.0` (quattro, Quickshell
shell), theme `Osaka Jade` (see `THEME`).

Covers every app Omarchy templates into `~/.config` (Hyprland, the Omarchy
shell — bar/menu/notifications/OSD via `omarchy/{shell.json,shell.toml,
plugins,defaults}` — terminals, btop, fastfetch, lazygit, starship, git,
fcitx5, and `~/.config/omarchy/{hooks,themes,extensions,branding,themed}`
for custom hooks and themes). Excludes `~/.config/chromium` — that's a
browser profile, not a setting — and Typora's Electron cache/tracking state
(only `conf/`, `profile.data`, `Preferences` are kept). Pre-quattro apps
(waybar, walker, swayosd, wiremix, elephant, the old `omarchy.ttf`) were
dropped from this backup after the August 2026 quattro migration retired
them in favor of the unified shell — see the `*.omarchy-upgrade-to-quattro.*`
backup files Omarchy itself left in `~/.config` if you need the old configs.

## Restore

On a fresh Omarchy install:

```sh
./install.sh
```

Backs up anything it would overwrite as `<name>.bak.<timestamp>` next to it,
then copies each directory into `~/.config`. Re-run safely any time.

After restoring, re-apply the theme (relinks `~/.config/omarchy/current`)
and restart the shell:

```sh
omarchy theme set "Osaka Jade"
omarchy restart shell
```

## Updating this backup

```sh
apps="alacritty autostart btop environment.d fastfetch \
  fcitx5 fontconfig foot ghostty git hypr hyprland-preview-share-picker \
  imv kitty lazygit obsidian opencode systemd tmux uwsm xournalpp"
for d in $apps; do rsync -a --delete "$HOME/.config/$d/" ".config/$d/"; done
rsync -a --delete "$HOME/.config/omarchy/"{hooks,themes,extensions,branding,themed,plugins,defaults} .config/omarchy/
cp "$HOME/.config/omarchy"/{shell.json,shell.toml} .config/omarchy/
cp "$HOME/.config"/{chromium-flags.conf,starship.toml,xdg-terminals.list} .config/
# Typora: only real settings and the custom ia_typora theme, not Typora's
# bundled default themes/fonts or its Electron cache/tracking state.
cp "$HOME/.config/Typora"/{profile.data,Preferences} .config/Typora/
cp -a "$HOME/.config/Typora/conf" .config/Typora/
cp "$HOME/.config/Typora/themes"/{ia_typora.css,ia_typora_night.css} .config/Typora/themes/
omarchy theme current > THEME
```
