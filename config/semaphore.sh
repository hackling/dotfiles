semaphorebreaks() {
  rspec $(
    cat "$1" |
    awk '{print $2}' |
    cut -d: -f1 |
    sort -u
  )
}
