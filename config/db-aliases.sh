alias migrations="rake db:migrate && rake db:test:prepare"
alias loaddump='pg_restore --no-acl --no-owner -d envision_development'
alias dropandload='rake db:drop && rake db:create && loaddump'

dlm() {
  if [[ $# -ne 1 ]] || [[ -z "$1" ]]; then
    echo "usage: dlm [database dump]" >&2
    return 1
  fi
  rake db:drop &&
  rake db:create &&
  loaddump "$1" &&
  rake db:migrate &&
  rake db:test:prepare &&
  rake db:obfuscate:all
}
