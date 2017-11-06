function prep-cc {
  brew services stop postgres
  plain-services-docker up -d postgres
}

function prep-zuul {
  plain-services-docker stop postgres
  plain-services-docker rm postgres
  plain-services-docker up -d redis rabbitmq
  brew services start postgres
}
