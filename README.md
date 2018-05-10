My personal dotfiles for bash on a Mac, for an opinionated development environment at Hyper Anna

## Pre-requisites
### Install GitHub client for bash
```bash
mkdir -p ~/code/other
cd ~/code/other
git clone https://github.com/sgerber-hyperanna/ok.sh.git
sudo ln -s ~/code/other/ok.sh/ok.sh /usr/local/bin/ok.sh
```

## Setup
Copy all files starting with '.' to your home directory. E.g.
```
cp .* ~/
```

## Useful things

These dotfiles provide some additional git and bash aliases:

### Bash functions
`clone <project>`: Clones an HA git project into ~/code/anna/<project name>. Has tab completion, but it's slow!
`p <project>`: Switches into any git project that is located in a subdirectory under ~/code. E.g. 'p anna-frontend'. Has tab completion.

### Git functions
`git lg`: Pretty coloured compact log with a tree
`git l`: Last 10 lines of the 'git lg' log
`git st`: Short for 'git status'

### Misc

* VIM improvements. e.g. syntax and line-numbers on by default
* Colorized 'lg' output
* Improved bash prompt with GIT status information
