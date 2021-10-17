#!/usr/bin/env bash
# Setup script for setting up a new macos machine
echo "Starting setup"
# install xcode CLI
xcode-select —-install
# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
# Update homebrew recipes
brew update
PACKAGES=(
    git
    htop
    wget
    speedtest-cli
    gh
    bat
    readline
)
echo "Installing packages..."
brew install ${PACKAGES[@]}
# any additional steps you want to add here
# link readline
brew link --force readline
echo "Cleaning up..."
brew cleanup
echo "Installing cask..."
CASKS=(
    iterm2
    adguard
    spotify
    visual-studio-code
    deluge
    dozer
    raycast
)
echo "Installing cask apps..."
brew cask install ${CASKS[@]}

echo "Configuring OS..."
# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0
# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# Setup mouse, trackpad speed
defaults write -g com.apple.mouse.scaling 2
defaults write -g com.apple.trackpad.scaling 2
# Git config
git config --global user.name "Ádám Pásztor" 
git config --global user.email mrpasztoradam@gmail.com
git config --global init.defaultBranch main
# github
gh auth login
echo "MacBook setup completed!"