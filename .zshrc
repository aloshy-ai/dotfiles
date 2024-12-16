# Initialize Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Set up PATH
export PATH="$HOME/bin:$PATH" # Include custom scripts
export PATH="/Applications/WebStorm.app/Contents/MacOS:$PATH" # Launch WebStorm from the command line
export PATH="/opt/homebrew/opt/libpq/bin:$PATH" # Enable Postgres CLI tools
export PATH="/opt/homebrew/opt/rustup/bin:$PATH" # Enable Rust CLI tools

# Initialize pyenv
eval "$(pyenv init --path)"

# Initialize Starship prompt
eval "$(starship init zsh)"

# Source ~/.bash_profile if it exists
[ -f ~/.bash_profile ] && . ~/.bash_profile

# Alias for copying SSH key
alias ssh-copy-id="ssh-copy-id -i ~/.ssh/aloshy.pub"

# NVM (Node Version Manager) configuration
export NVM_DIR=/Users/aloshy/.nvm
[ -s /opt/homebrew/opt/nvm/nvm.sh ] && \. /opt/homebrew/opt/nvm/nvm.sh  # Load NVM
[ -s /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm ] && \. /opt/homebrew/opt/nvm/etc/bash_completion.d/nvm  # Load NVM completion
