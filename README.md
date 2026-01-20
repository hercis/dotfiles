See https://www.atlassian.com/git/tutorials/dotfiles

## My setup
### Installing my dotfiles onto a new system
Run in current shell:
> git clone --bare git@github.com:hercis/dotfiles.git $HOME/.dotfiles

> alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

> dotfiles checkout

> dotfiles config --local status.showUntrackedFiles no

