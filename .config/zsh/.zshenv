# https://tanguy.ortolo.eu/blog/article25/shrc
#
# Zsh always executes zshenv. Then, depending on the case:
# - run as a login shell, it executes zprofile;
# - run as an interactive, it executes zshrc;
# - run as a login shell, it executes zlogin.
#
# At the end of a login session, it executes zlogout, but in reverse order, the
# user-specific file first, then the system-wide one, constituting a chiasmus
# with the zlogin files.

# https://www.zsh.org/mla/users/2021/msg00879.html
skip_global_compinit=1

##
## Paths
##
typeset -gU cdpath fpath manpath path

cdpath=(
  $HOME/code
  $cdpath
)

# Homebrew prefix is /user/local so it's covered below
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

export MAVEN_HOME="$HOME/apache-maven-3.8.6"
export PYENV_ROOT="$HOME/.pyenv"

# Best breakdown of how pathing works in zsh
# https://gist.github.com/Linerre/f11ad4a6a934dcf01ee8415c9457e7b2
path=(
  $PYENV_ROOT/bin
  $MAVEN_HOME
  $BREW_PREFIX/{bin,sbin}
  /usr/local/opt/mysql@5.7/bin
  /usr/local/opt/protobuf@3/bin
  ${GOPATH//://bin:}/bin
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
  $path
)

# PACMAN
export DYLD_LIBRARY_PATH=/usr/local/bin
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
