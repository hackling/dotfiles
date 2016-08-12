alias v="nvim -u ~/.vimrc"
alias vim="nvim -u ~/.vimrc"
alias whatalias=" alias | grep"
alias xx="exit"
alias killrspec="pkill -fl rspec"
alias checkhaml='bundle exec haml-lint $(find app/views/* -maxdepth 0 -type d -not -name kss)'
alias cleancontainers="docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm"
alias cleanimages="docker images | awk '$1 == \"<none>\" {print $3}' | xargs docker rmi"
