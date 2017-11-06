notes() {
  if [ ! -z "$1" ]; then
    case "$1" in
      "edit") vim $HOME/.notes ;;
      *) echo "$@" >> "$HOME/.notes" ;;
    esac
  else
    cat "$HOME/.notes"
  fi
}
