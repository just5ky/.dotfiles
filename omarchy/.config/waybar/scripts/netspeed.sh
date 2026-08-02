#!/bin/bash
# ponytail: single global state file, assumes one active default-route iface (fine for single-NIC laptop/desktop)
iface=$(ip route show default | awk '{print $5; exit}')
[[ -z "$iface" ]] && { echo '{"text":"󰤮 --"}'; exit 0; }

rx=$(cat "/sys/class/net/$iface/statistics/rx_bytes" 2>/dev/null || echo 0)
tx=$(cat "/sys/class/net/$iface/statistics/tx_bytes" 2>/dev/null || echo 0)
now=$(date +%s.%N)

state="/tmp/waybar-netspeed.state"
prev=$(cat "$state" 2>/dev/null || echo "$rx $tx $now")
echo "$rx $tx $now" > "$state"

awk -v rx="$rx" -v tx="$tx" -v now="$now" -v prev="$prev" '
function human(b) {
  if (b < 1024) return sprintf("%dB/s", b)
  if (b < 1048576) return sprintf("%.0fK/s", b / 1024)
  return sprintf("%.1fM/s", b / 1048576)
}
BEGIN {
  split(prev, p, " ")
  dt = now - p[3]
  if (dt <= 0) dt = 1
  drx = (rx - p[1]) / dt
  dtx = (tx - p[2]) / dt
  if (drx < 0) drx = 0
  if (dtx < 0) dtx = 0
  printf "{\"text\":\"󰇚 %s  󰕒 %s\"}\n", human(drx), human(dtx)
}'
