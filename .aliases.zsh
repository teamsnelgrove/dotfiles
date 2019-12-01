# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadcli="source $HOME/.zshrc"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"
alias ls='ls --color=always'
alias ll="/usr/local/opt/coreutils/libexec/gnubin/ls -ahlF --color --group-directories-first"

weather() { curl -4 wttr.in/${1:-alexandria} }

# DivvyCloud helpers
dv() {
    ARGS="${@}" make run-dv
}


