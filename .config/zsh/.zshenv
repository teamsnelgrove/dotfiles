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

# Set ZDOTDIR if you want to re-home Zsh.
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}

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
  # $PYENV_ROOT/bin
  $MAVEN_HOME/bin
  $HOME/.cargo/bin
  $BREW_PREFIX/{bin,sbin}
  # /usr/local/opt/mysql@5.7/bin
  /usr/local/opt/protobuf@3/bin
  ${GOPATH//://bin:}/bin
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  $HOME/.config/zsh/bin
  /{bin,sbin}
  $path
)

function helix-git-blame {

  HELIX_PANE_ID=$(wezterm cli get-pane-direction Up)
  FILE_LINE=$(wezterm cli get-text --pane-id $HELIX_PANE_ID)
  RES=$(echo $FILE_LINE | rg -e "(?:NOR|INS|SEL)\s+(\S*)\s[^│]* (\d+):*.*" -o --replace '$1 $2')
  FILE=$(echo $RES | awk '{ print $1}')
  LINE=$(echo $RES | awk '{ print $2}')

  SHA=$(git blame -lts -L $LINE,+1 $FILE | awk '{ print $1 }')
# Grab the first PR from the list
# TODO: make this a fzf picker
  PR_NUMBER=$(gh pr list --search $SHA --state merged --json number --jq '.[0].number')
  gh pr view $PR_NUMBER --web
}


# PACMAN
export DYLD_LIBRARY_PATH=/usr/local/bin
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Shim asdf
. "$HOME/.asdf/asdf.sh"
