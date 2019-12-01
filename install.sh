#!/bin/sh

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# TODO: cat /Users/snelgrove/.zprofile pathing is changed here


# Removes .zshrc from $HOME (if it exists) and symlinks the .zshrc file from the .dotfiles
rm -rf $HOME/.zshrc
ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

# Simlink emacs into ~/Applications folder
# https://www.emacswiki.org/emacs/EmacsForMacOS
# ln -Fs $(find /usr/local -name "Emacs.app") /Applications/Emacs.app

# Fetch Spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# Set OS X preferences
# We will run this last because this will reload the shell
source .macos
