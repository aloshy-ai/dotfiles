# HOMEBREW
eval "$(/opt/homebrew/bin/brew shellenv)"

# PATH ENVS
export PATH="/Applications/WebStorm.app/Contents/MacOS:$PATH"
export PATH="/opt/homebrew/opt/mongodb-community@5.0/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# PYENV
eval "$(pyenv init --path)"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# BASH PROFILE (IF ANY)
source ~/.bash_profile

# LOCAL NODE BINARIES OF PWD
export PATH="./node_modules/.bin:$PATH"

# STARSHIP
eval "$(starship init zsh)"

# DIRENV
eval "$(direnv hook bash)"

# RUSTUP
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"

# COPY ALOSHY KEY BY DEFAULT
alias ssh-copy-id="ssh-copy-id -i ~/.ssh/aloshy.pub"

# NVM
export NVM_DIR=/Users/aloshy/.nvm
        [ -s /opt/homebrew/opt/nvm/nvm.sh ] && \. /opt/homebrew/opt/nvm/nvm.sh  # This loads nvm
        [ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ] && \. /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm  # This loads nvm bash_completion

echo "░▒▓█ ZSHRC LOADED █▓▒░"
