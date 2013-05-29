# allows variable substitution in the prompt
setopt prompt_subst

autoload colors; colors;
autoload -Uz vcs_info

# only show user and hostname when connected as root user or via ssh
user_hostname() {
  if [[ "$USER" = "root" || -n "$SSH_TTY" ]]; then
    echo " "`whoami`@`hostname`
  fi
}

prompt_color() {
  if [ "$USER" = "root" ]; then
    echo "red"
  else
    if [ -n "$SSH_TTY" ]; then
      echo "green"
    else
      echo "yellow"
    fi
  fi
}

prompt_bg_job() {
  jobs | grep '+' | awk '{print $4}'
}

# show number of stashed items
git_stash() {
  git stash list 2> /dev/null | wc -l | sed -e "s/ *\([0-9]*\)/\ \+\1/g" | sed -e "s/ \+0//"
}

function prompt_pwd() {
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    local repo="$(basename "$(git rev-parse --show-toplevel)")"
  fi

  parts=(${(s:/:)${${PWD}/#${HOME}/\~}})

  i=0
  while (( i++ < ${#parts} )); do
    part="$parts[i]"
    if [[ "$part" == "$repo" ]]; then
      # if this part of the path represents the repo,
      # underline it, and skip truncating the component
      parts[i]="%U$part%u"
    else
      # shorten the path as long as it isn't the last piece
      if [[ "$parts[${#parts}]" != "$part" ]]; then
        parts[i]="$part[1,1]"
      fi
    fi
  done

  local prompt_path="${(j:/:)parts}"
  if [ "$parts[1]" != "~" ]; then
    prompt_path="/$prompt_path"
  fi
  echo "$prompt_path"
}

local git_formats="%{${fg[yellow]}%}± %b%c%u%{${reset_color}%}"
zstyle ':vcs_info:*' stagedstr '%F{28}●'
zstyle ':vcs_info:*' unstagedstr '%F{11}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn

precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' %c%u %F{magenta}%b'
    } else {
        zstyle ':vcs_info:*' formats ' %c%u%F{red}● %F{magenta}%b'
    }
    vcs_info
}

local cwd='%{${fg[green]}%}$(prompt_pwd)%{${reset_color}%}'
local usr='%{${fg[yellow]}%}$(user_hostname)%{${reset_color}%} '
local char='%{${fg[$(prompt_color)]}%}»%{${reset_color}%} '
local git=' ${vcs_info_msg_0_} '
local timestamp='%F{yellow}%* '
local vi_mode='$(which vi_mode_prompt_info &> /dev/null && vi_mode_prompt_info) '
local bg_job='%{${fg[black]}%}$(prompt_bg_job)%{${reset_color}%} '
local reset='%{$reset_color'

PROMPT=$cwd$usr$char
RPROMPT=$vi_mode$bg_job$git$timestamp$reset

PROMPT2=$char
RPROMPT2='[%_]'
