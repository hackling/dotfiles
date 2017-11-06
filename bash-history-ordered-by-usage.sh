cat .bash_history.back  | sort | uniq -c | sort | awk '{first = $1; $1 = ""; print $0 }' > .bash_history_ordered
