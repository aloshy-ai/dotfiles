eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(direnv hook zsh)"
eval "$(direnv hook zsh)"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Exporting Secrets from iCloud Keychain to Environment Variables
export KS_DEFAULT_KEYCHAIN="iCloud"
export ANTHROPIC_API_KEY=$(ks show ANTHROPIC_API_KEY 2>/dev/null)
