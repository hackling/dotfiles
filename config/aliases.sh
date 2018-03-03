alias whatalias=" alias | grep"
alias xx="exit"
alias killrspec="pkill -fl rspec"
alias cleancontainers="docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm"
alias cleanimages="docker images | grep '<none>' | awk {'print $3'} | xargs -n 1 docker rmi"
alias olga="say --voice=Milena"
alias dc="docker-compose"
alias s="cat ~/.bash_history | sort -u | fzf"
function ag {
  echo "Use ripgrep instead"
}
# function bind_and_print(){
#   bind '"\e[0n": "'"$@"'"'; printf '\e[5n'
# }
# bind -x '"\C-r":"bind_and_print $(echo "this that")"'
# bind -x '"\C-r":"bind_and_print $(cat ~/.bash_history | sort -u | fzf)"'
alias addkey="ssh-add -K ~/.ssh/id_rsa"
