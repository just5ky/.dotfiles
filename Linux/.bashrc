# ~/.bashrc

# --- CIS Hardening (CIS Linux Benchmark §5.4) ---
# CIS 5.4.4: Restrict default file permissions
umask 027

# CIS 5.4.5: Auto-logout after 15 min inactivity
readonly TMOUT=900; export TMOUT

# CIS 5.4.3: History hardening — drop leading-space cmds and duplicates
export HISTCONTROL=ignorespace:erasedups
export HISTSIZE=1000
export HISTFILESIZE=2000

# PATH safety — strip '.' and empty segments to prevent PATH hijacking
PATH=$(echo "$PATH" | tr ':' '\n' | grep -v -e '^\.$' -e '^$' | tr '\n' ':' | sed 's/:$//')
export PATH
# --- End CIS Hardening ---

eval "$(starship init bash)"
