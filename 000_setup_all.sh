#!/bin/bash

# Install Command Line Tools
xcode-select –-install

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew to path"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew is already installed."
fi

# Update Homebrew
brew update

# Upgrade all installed Homebrew packages
brew upgrade

# Clean up old versions of packages
brew cleanup

# Generate SSH Keys
SSH_KEY_PATH="$HOME/.ssh/id_ecdsa"

# Check if the SSH key already exists
if [[ -f "$SSH_KEY_PATH" ]]; then
    echo "SSH key already exists at $SSH_KEY_PATH."
else
    echo "SSH key not found. Generating a new one..."
    
    # Generate a new SSH key if not present
    ssh-keygen -q -t ecdsa -N '' -f "$SSH_KEY_PATH" <<< $'\ny' >/dev/null 2>&1
    
    if [[ $? -eq 0 ]]; then
        echo "SSH key successfully generated at $SSH_KEY_PATH."
    else
        echo "Failed to generate SSH key."
        exit 1
    fi
fi

# Adding Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
