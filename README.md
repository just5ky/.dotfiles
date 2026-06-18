# dotfiles

> Personal shell configuration for Windows and Linux — CIS-hardened, prompt-themed with [Starship](https://starship.rs) and [Oh My Posh](https://ohmyposh.dev).

Inspired by [Xcad2k/dotfiles](https://github.com/xcad2k/dotfiles)

![Powershell](https://user-images.githubusercontent.com/71321862/160266439-51cae5bc-d843-490a-92d2-28a84e4d9ca9.png)
![Linux](https://user-images.githubusercontent.com/71321862/160266535-24ee625b-7571-4304-8e47-aa5654b30b15.png)

---

## Contents

```
.
├── Linux/
│   ├── .bashrc          # Bash — CIS-hardened shell init
│   ├── .zshrc           # Zsh  — CIS-hardened shell init
│   ├── .tcshrc          # Tcsh — CIS-hardened shell init
│   └── startship.toml   # Starship prompt theme (Linux)
└── windows/
    ├── Microsoft.PowerShell_profile.ps1   # PowerShell profile — CIS-hardened
    ├── starship.toml                      # Starship prompt theme (Windows)
    └── hackthebox.omp.json                # Oh My Posh — HackTheBox theme
```

---

## Security Hardening

All shell configs are hardened against the **CIS Linux Benchmark §5.4** (Linux) and **PowerShell STIG** (Windows). Controls applied:

| Control | Linux (bash/zsh/tcsh) | PowerShell |
|---|---|---|
| Session timeout | `TMOUT=900` (15 min, readonly) | — |
| Default umask | `umask 027` | — |
| History privacy | `HISTCONTROL=ignorespace:erasedups` / `setopt HIST_IGNORE_SPACE` | `AddToHistoryHandler` drops lines matching `password\|token\|secret\|…` |
| History size cap | `HISTSIZE=1000` / `SAVEHIST=1000` | `MaximumHistoryCount 1000` |
| History persistence | — | `HistorySaveStyle SaveIncrementally` |
| PATH safety | Strips `.` and empty segments | — |

> **Note:** `trim_at` in both Starship configs uses `.local` — replace with your actual domain if needed.

---

## Prerequisites

- A [Nerd Font](https://www.nerdfonts.com/) installed and enabled in your terminal  
  (configs use [JetBrains Mono Nerd Font](https://www.nerdfonts.com/font-downloads))

---

## Installation

### Linux

**1. Install Starship**

```sh
curl -sS https://starship.rs/install.sh | sh
```

<details>
<summary>Package manager alternatives</summary>

| Distro | Command |
|---|---|
| Arch / Manjaro | `pacman -S starship` |
| Fedora 31+ | `dnf install starship` |
| Alpine 3.13+ | `apk add starship` |
| NixOS | `nix-env -iA nixos.starship` |
| Any (cargo) | `cargo install starship --locked` |
| Any (snap) | `snap install starship` |
| Any (brew) | `brew install starship` |

</details>

**2. Copy configs**

```sh
# Shell init (pick yours)
cp Linux/.bashrc ~/.bashrc
cp Linux/.zshrc  ~/.zshrc
cp Linux/.tcshrc ~/.tcshrc

# Starship theme
mkdir -p ~/.config
cp Linux/startship.toml ~/.config/starship.toml
```

**3. Reload your shell**

```sh
source ~/.bashrc   # or ~/.zshrc / ~/.tcshrc
```

---

### Windows (PowerShell)

**1. Install Starship**

```powershell
winget install Starship.Starship
# or
choco install starship
# or
scoop install starship
```

**2. Install required PowerShell modules**

```powershell
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
```

**3. Copy configs**

```powershell
# PowerShell profile
Copy-Item windows\Microsoft.PowerShell_profile.ps1 $PROFILE

# Starship theme
New-Item -ItemType Directory -Force "$HOME\.starship"
Copy-Item windows\starship.toml "$HOME\.starship\starship.toml"
```

**4. Reload profile**

```powershell
. $PROFILE
```

---

### Optional: Oh My Posh (Windows)

```powershell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

Copy the theme and uncomment the `oh-my-posh` line in the PowerShell profile:

```powershell
Copy-Item windows\hackthebox.omp.json "$env:LOCALAPPDATA\Programs\oh-my-posh\themes\hackthebox.omp.json"
```

Then in `Microsoft.PowerShell_profile.ps1`, uncomment:

```powershell
# oh-my-posh init pwsh --config '...\hackthebox.omp.json' | Invoke-Expression
```

---

## Shell Support

| Shell | Platform | Prompt |
|---|---|---|
| Bash | Linux | Starship |
| Zsh | Linux | Starship |
| Tcsh | Linux | Starship |
| PowerShell | Windows | Starship / Oh My Posh |

---

## References

- [Starship docs](https://starship.rs/config/)
- [Oh My Posh docs](https://ohmyposh.dev/docs)
- [CIS Linux Benchmark](https://www.cisecurity.org/benchmark/debian_linux)
- [PSReadLine docs](https://learn.microsoft.com/en-us/powershell/module/psreadline/)
- [Terminal-Icons](https://github.com/devblackops/Terminal-Icons)
