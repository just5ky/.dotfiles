# ~/.zshrc

# --- CIS Hardening (CIS Linux Benchmark §5.4) ---
# CIS 5.4.4: Restrict default file permissions
umask 027

# CIS 5.4.5: Auto-logout after 15 min inactivity
readonly TMOUT=900; export TMOUT

# CIS 5.4.3: History hardening
export HISTSIZE=1000
export SAVEHIST=1000
setopt HIST_IGNORE_SPACE HIST_IGNORE_DUPS HIST_EXPIRE_DUPS_FIRST
# --- End CIS Hardening ---

eval "$(starship init zsh)"
