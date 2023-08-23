set -e

pushd "$HOME/dotfiles"
stow nvim
stow wezterm
stow starship
stow direnv
popd
