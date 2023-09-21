set -e

pushd "$HOME/dotfiles"
stow btop
stow direnv
stow nvim
stow skhd
stow starship
stow wezterm
stow yabai
popd
