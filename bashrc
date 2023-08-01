export MANPAGER="sh -c 'col -bx | bat -l man -p'"

batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

alias gitupsub='git submodule update --remote --recursive'

# change base repo branch, and it's submodules
# https://stackoverflow.com/a/18799234
gitch()
{
    git checkout $1
    git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; git switch $branch'
}

# show branch name. May not work in Fedora
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:$(__git_ps1 "\[\e[1;33m\](%s)\[\e[0m"\]) \[\033[01;34m\]\w\[\033[00m\]\$ '
