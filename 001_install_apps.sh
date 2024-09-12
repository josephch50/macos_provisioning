#!/bin/bash

# File containing the list of applications to install
APPS_FILE="apps.txt"

# Update Homebrew
brew update

# Upgrade all installed Homebrew packages
brew upgrade

# Install applications
while IFS= read -r line; do
    # Skip empty lines and comments
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    
    # Determine whether to use Homebrew or Homebrew Cask
    if [[ "$line" == *"--cask" ]]; then
        app_name=${line%% --cask}
        echo "Installing $app_name via Homebrew Cask..."
        brew install --cask "$app_name"
    else
        app_name="$line"
        echo "Installing $app_name via Homebrew..."
        brew install "$app_name"
    fi
done < "$APPS_FILE"

# Clean up old versions of packages
brew cleanup
