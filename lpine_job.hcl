job "gogs-build" {
  datacenters = ["dc1"]

  group "build" {
    task "setup" {
      driver = "docker"
      config {
        image = "alpine:3.15"
        command = "/bin/sh"
        args = [
          "-c",
          "echo -e 'https://alpine.global.ssl.fastly.net/alpine/v3.18/community' > /etc/apk/repositories &&
          echo -e 'https://alpine.global.ssl.fastly.net/alpine/v3.18/main' >> /etc/apk/repositories &&
          apk update &&
          apk add --no-cache binutils go postgresql-client git openssh &&
          go build -o gogs -buildvcs=false &&
          go test -v -cover ./..."
        ]
      }
    }
  }
}
