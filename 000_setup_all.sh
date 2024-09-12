#!/bin/bash

# Install Command Line Tools
xcode-select –-install

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew to path"
    (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/joe/.zprofile
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
ssh-keygen -q -t ecdsa -N '' <<< $'\ny' >/dev/null 2>&1

# Adding Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
