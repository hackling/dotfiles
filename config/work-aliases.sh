function prep-cc {
  brew services stop postgres
  plain-services-docker up -d postgres
}

function prep-zuul {
  plain-services-docker stop postgres
  plain-services-docker rm postgres
  brew services start postgres
}
