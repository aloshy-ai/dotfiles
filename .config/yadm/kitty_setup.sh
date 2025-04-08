#!/bin/bash
# Kitty Terminal Setup - yadm bootstrap section
# Add this to your yadm bootstrap script to replace Terminal with Kitty

kitty_terminal_setup() {
  echo "==== Setting up Kitty as default terminal ===="
  
  # Check if running on macOS
  if [[ "$(uname)" != "Darwin" ]]; then
    echo "Not running on macOS, skipping Kitty terminal setup"
    return 0
  fi
  
  # Install Kitty if not already installed
  if [ ! -d "/Applications/kitty.app" ]; then
    echo "Installing Kitty terminal..."
    if command -v brew >/dev/null 2>&1; then
      brew install --cask kitty
    else
      echo "Homebrew not found, attempting direct download..."
      curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    fi
    
    if [ ! -d "/Applications/kitty.app" ]; then
      echo "Failed to install Kitty. Please install it manually."
      return 1
    fi
  fi
  echo "✅ Kitty is installed"
  
  # Create Terminal.app redirector
  echo "Creating Terminal.app redirector..."
  sudo mkdir -p "/Applications/Terminal.app/Contents/MacOS"
  sudo mkdir -p "/Applications/Terminal.app/Contents/Resources"
  
  sudo tee "/Applications/Terminal.app/Contents/MacOS/Terminal" > /dev/null << 'SCRIPT'
#!/bin/bash
# Redirect to kitty
open -a /Applications/kitty.app "$@"
SCRIPT
  
  sudo chmod +x "/Applications/Terminal.app/Contents/MacOS/Terminal"
  
  sudo tee "/Applications/Terminal.app/Contents/Info.plist" > /dev/null << 'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleIdentifier</key>
    <string>com.user.TerminalRedirect</string>
    <key>CFBundleName</key>
    <string>Terminal</string>
    <key>CFBundleDisplayName</key>
    <string>Terminal</string>
    <key>CFBundleExecutable</key>
    <string>Terminal</string>
</dict>
</plist>
PLIST
  
  echo "✅ Created Terminal.app redirector"
  
  # Add Spotlight metadata
  echo "Adding terminal keyword metadata to Kitty..."
  cat > /tmp/terminal_keywords.plist << 'XML'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
  <string>terminal</string>
  <string>term</string>
  <string>command line</string>
  <string>shell</string>
  <string>console</string>
</array>
</plist>
XML
  
  plutil -convert binary1 -o /tmp/terminal_keywords.bin /tmp/terminal_keywords.plist
  KEYWORD_HEX=$(xxd -p /tmp/terminal_keywords.bin | tr -d '\n')
  sudo xattr -wx com.apple.metadata:kMDItemKeywords "$KEYWORD_HEX" "/Applications/kitty.app"
  
  echo "✅ Added Spotlight metadata"
  
  # Set file associations
  echo "Setting Kitty as default terminal handler..."
  KITTY_BUNDLE_ID=$(defaults read "/Applications/kitty.app/Contents/Info" CFBundleIdentifier 2>/dev/null || echo "net.kovidgoyal.kitty")
  
  for handler in "public.unix-executable" "public.shell-script" "x-apple.terminal"; do
    if [[ "$handler" == x-apple* ]]; then
      defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
        "{LSHandlerURLScheme=$handler;LSHandlerRoleAll=$KITTY_BUNDLE_ID;}"
    else
      defaults write com.apple.LaunchServices/com.apple.launchservices.secure LSHandlers -array-add \
        "{LSHandlerContentType=$handler;LSHandlerRoleAll=$KITTY_BUNDLE_ID;}"
    fi
  done
  
  echo "✅ Set file associations"
  
  # Add shell aliases
  shell_config=""
  if [ -f "$HOME/.zshrc" ]; then
    shell_config="$HOME/.zshrc"
  elif [ -f "$HOME/.bashrc" ]; then
    shell_config="$HOME/.bashrc"
  fi
  
  if [ -n "$shell_config" ]; then
    if ! grep -q "alias terminal='open -a kitty'" "$shell_config"; then
      echo "" >> "$shell_config"
      echo "# Alias to launch kitty when 'terminal' is typed" >> "$shell_config"
      echo "alias terminal='open -a kitty'" >> "$shell_config"
      echo "alias term='open -a kitty'" >> "$shell_config"
      echo "✅ Added shell aliases to $shell_config"
    else
      echo "Shell aliases already exist"
    fi
  else
    echo "No shell config found, skipping aliases"
  fi
  
  # Create Finder service
  echo "Creating 'Open in Terminal' Finder service..."
  mkdir -p "$HOME/Library/Services/"
  
  cat > /tmp/OpenInKittyService.scpt << 'APPLESCRIPT'
on run {input, parameters}
	set thePath to POSIX path of (input as text)
	tell application "kitty"
		activate
		tell application "System Events"
			keystroke "cd " & quoted form of thePath & " && clear" & return
		end tell
	end tell
	return input
end run
APPLESCRIPT
  
  osacompile -o "$HOME/Library/Services/Open in Kitty.workflow" /tmp/OpenInKittyService.scpt
  
  echo "✅ Created Finder service"
  
  # Update Launch Services database
  echo "Updating Launch Services database..."
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
  
  echo "✅ Updated Launch Services database"
  
  # Restart services
  echo "Restarting Dock, Finder, and reindexing Spotlight..."
  killall Dock
  killall Finder
  sudo mdutil -E /
  
  echo "==== Kitty terminal setup complete! ===="
  echo "You may need to restart your computer for all changes to take effect."
}

# Uncomment the line below to test the function directly:
# kitty_terminal_setup

# To use in yadm bootstrap script, add this file to your repo and source it like:
# source path/to/kitty_yadm_bootstrap.sh
# kitty_terminal_setup
