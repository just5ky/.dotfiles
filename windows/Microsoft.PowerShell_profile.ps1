# code $Profile

$ENV:STARSHIP_CONFIG = "$HOME\.starship\starship.toml"
$ENV:STARSHIP_DISTRO = "SKY "
Invoke-Expression (&starship init powershell)

## Oh My Posh
# oh-my-posh init pwsh --config 'C:\Users\justsky\AppData\Local\Programs\oh-my-posh\themes\hackthebox.omp.json' | Invoke-Expression


Import-Module -Name Terminal-Icons

# --- CIS Hardening (CIS Windows / PowerShell STIG) ---
# PS STIG: Cap history size and persist incrementally
Set-PSReadLineOption -MaximumHistoryCount 1000
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally

# PS STIG: Drop commands containing secrets from history
Set-PSReadLineOption -AddToHistoryHandler {
    param([string]$line)
    $sensitive = 'password|passwd|token|secret|apikey|api_key|credential|connectionstring'
    return ($line -notmatch $sensitive)
}
# --- End CIS Hardening ---

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}