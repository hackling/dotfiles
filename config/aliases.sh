alias v="nvim -u ~/.vimrc"
alias vim="nvim -u ~/.vimrc"
alias whatalias=" alias | grep"
alias xx="exit"
alias killrspec="pkill -fl rspec"
alias fastcop='git diff --name-only origin/develop | grep \\.rb$ | xargs ls 2>/dev/null | xargs bundle exec rubocop --config .rubocop.yml --force-exclusion'
alias checkhaml='bundle exec haml-lint $(find app/views/* -maxdepth 0 -type d -not -name kss)'
