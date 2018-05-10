export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_152.jdk/Contents/Home
PYTHON_BIN=~/Library/Python/3.6/bin

# Use vi mode
set -o vi

# PROMPT CONFIG
source ~/.bash_prompt

# COLOR COMMANDS
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -G'
alias grep='grep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias egrep='egrep --colour=auto'

# ALIASES
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

export EDITOR="vim"

if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

BASH_COMPLETION_DIR=$(brew --prefix)/etc/bash_completion.d
if [ -d $BASH_COMPLETION_DIR ]; then
	for f in $BASH_COMPLETION_DIR/*; do LC_CTYPE=C source $f; done
fi 

clone() {
	local PROJECT=$1
	local PROJECT_DIR=~/code/anna/$PROJECT

	if [[ ! -d $PROJECT_DIR ]]; then 
		mkdir -p ~/code/anna
		cd ~/code/anna
		git clone https://github.com/hyperanna01/$1.git
	else
		echo "Project seems to already be cloned."
	fi
}

_clone() {
	local cur
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $(compgen -W "$(ok.sh list_repos | awk '{print $1}')" -- $cur ) )
}

p() {
	DIR_TO_FIND=$1
	LOCATION=$(find ~/code -maxdepth 2 -type d -name "$DIR_TO_FIND" -print -quit)

	if [[ -d $LOCATION ]]; then
		cd $LOCATION
	fi
}

_p() {
	local cur
	COMPREPLY=()
	cur=${COMP_WORDS[COMP_CWORD]}
	COMPREPLY=( $(compgen -W "$(ls -r -d ~/code/*/* | cut -d "/" -f 6)" -- $cur ) )
}

complete -F _p p
complete -F _clone clone
