#!/bin/bash

# Define the list of bundle identifiers for applications
app_identifiers=(
    "com.apple.iChat"
    "com.apple.FaceTime"
    "com.microsoft.VSCode"
    "com.apple.Notes"
    "com.googlecode.iterm2"
)

# Define the list of directories for special folders
folders=(
    "/Applications"
    "~/Downloads"
)

# Clear the current Dock configuration
defaults write com.apple.dock persistent-apps -array
defaults write com.apple.dock persistent-others -array

# Add applications to the Dock
for bundle_id in "${app_identifiers[@]}"; do
    defaults write com.apple.dock persistent-apps -array-add \
        "{\"tile-type\"=\"regular\"; \"tile-data\"={\"bundle-identifier\"=\"$bundle_id\";}}"
done

# Add directories to the Dock
for dir in "${folders[@]}"; do
    defaults write com.apple.dock persistent-others -array-add \
        "{\"tile-type\"=\"directory\"; \"tile-data\"={\"file-data\"={\"_CFURLString\"=\"$dir\"; \"_CFURLStringType\"=15;}};}"
done

# Configure Dock
defaults write com.apple.dock autohide -bool false
defaults write com.apple.dock tilesize -int 36

# Apply the changes
killall Dock
