function __git_in_repo() { __gitdir > /dev/null; }
function __git_is_dirty() { git status --porcelain | grep -q .; }
function __git_dirty() { __git_in_repo && __git_is_dirty && echo "$1"; }
function __git_clean() { __git_in_repo && (__git_is_dirty || echo "$1"); }

export PS1='$(__git_ps1 "\[\e[37m\](\[\e[0m\]")$(__git_dirty "\[\e[35m\]✗\[\e[0m\]")$(__git_clean "\[\e[32m\]✓\[\e[0m\]")$(__git_ps1 " \[\e[34m\]%s\[\e[0m\]\[\e[37m\])\[\e[0m\] ")\[\e[36m\]\w\[\e[0m\]\[\e[33m\]\$\[\e[0m\] '
