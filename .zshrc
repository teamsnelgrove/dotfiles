# vim: set ft=zsh sw=2 et :
# Via https://tanguy.ortolo.eu/blog/article25/shrc
#
# Zsh always executes zshenv. Then, depending on the case:
# - run as a login shell, it executes zprofile;
# - run as an interactive, it executes zshrc;
# - run as a login shell, it executes zlogin.
#
# At the end of a login session, it executes zlogout, but in reverse order, the
# user-specific file first, then the system-wide one, constituting a chiasmus
# with the zlogin files.

test -r ~/.shell-aliases && source ~/.shell-aliases
test -r ~/.shell-env && source ~/.shell-env
test -r ~/.shell-env.local && source ~/.shell-env.local

# Required by 1Password line below.
# Normally this would have been called by a zsh plugin manager
autoload -Uz compinit
compinit

# Load 1Password completions
eval "$(op completion zsh)"; compdef _op op
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
