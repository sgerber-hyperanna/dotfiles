pr() {
    if ! git rev-parse --is-inside-work-tree &>/dev/null ; then
        echo "You are not in a git repository. Please execute this script inside a HyperAnna git repository"
        return 1
    fi

    if ! git remote show origin -n | grep -q hyperanna01 ; then
        echo "You are not in a HyperAnna github repository. Please execute this script inside a HyperAnna git repository."
        return 1
    fi

    if [ "$#" -ne 1 ]; then
        echo "Illegal number of parameters"
        echo "Usage $0 '<pull request title>'"
        return 1
    fi

    local pr_title=$1
    local current_repo=hyperanna01/$(basename $(git rev-parse --show-toplevel))
    local current_branch=$(git rev-parse --abbrev-ref HEAD)
    local target_branch="master"

    if git branch -rl | grep -q integration$ ; then
        target_branch="integration"
    fi

    if [[ ${current_branch} == ${target_branch} ]]; then
        echo "You cannot open a pull request from ${current_branch} to itself. Please switch to another branch"
        return 1
    fi

    ok.sh create_pull_request ${current_repo} "${pr_title}" ${current_branch} ${target_branch}
}

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
