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
