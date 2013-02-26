function get_pwd() {
  print -D $PWD
}

function put_spacing() {
  local git=$(git_prompt_info)
  if [ ${#git} != 0 ]; then
    ((git=${#git} - 10))
  else
    git=0
  fi

  local termwidth
  (( termwidth = ${COLUMNS} - 20 - ${#HOST} - ${#$(get_pwd)} - ${git} ))

  local spacing="-"
  local output=""
  for i in {1..$termwidth}; do
    output="${output}${spacing}"
  done
  echo "${output}"
}

local current_dir='${PWD/#$HOME/~}'

local spacing='$(put_spacing)$reset_color'
local git='$reset_color$(git_prompt_info)'
# The time
local p_time="%{$PR_BOLD%}%D{%L:%M%p}"


PROMPT="
$fg[cyan]╭─ $fg[green]${p_time} $fg[cyan]- $fg[yellow]${current_dir}$fg[cyan] ${spacing}$fg[cyan]---${git}$fg[cyan]---◇
╰─→ $reset_color"
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red][+"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]["
ZSH_THEME_GIT_PROMPT_PREFIX="git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
