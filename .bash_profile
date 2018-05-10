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