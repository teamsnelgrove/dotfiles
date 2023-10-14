# dotfiles
My dotfiles

### Bare your sole

I'm using the [bare git repository](https://www.atlassian.com/git/tutorials/dotfiles) 
methodology here for managing files. You can find the OG Hacker News thread
[here](https://news.ycombinator.com/item?id=11070797).

TLDR; you split the git directory from the working directory.

Set up an alias in `~/.zshrc`

```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

```
Clone the repo with `--bare` and then checkout the `master` branch.

```bash
git clone --bare git@github.com:teamsnelgrove/dotfiles.git $HOME/.dotfiles
dotfiles checkout master
```

We don't wanna see all untracked files every time we do `git status`.

```bash
dotfiles config --local status.showUntrackedFiles no
```

From here we use the alias as we normally would use git. Just need to be
careful not to add untracked files by accident or forget to include them.

