export MANPAGER="sh -c 'col -bx | bat -l man -p'"

source ~/.bash_git

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

# for preview window in vim
export BAT_THEME=gruvbox-dark

# fix colors https://github.com/mliszcz/dotfiles/commit/29357f27c49ee7bf956bc81218ec258a5640fe86
export MANROFFOPT="-c"

# show branch name. May not work in Fedora
# export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:$(__git_ps1 "\[\e[1;33m\](%s)\[\e[0m"\]) \[\033[01;34m\]\w\[\033[00m\]\$ '
