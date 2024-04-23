job "gogs" {
  region      = "global"
  datacenters = ["dc1"]
  type        = "service"

  group "gogs-group" {
    count = 1

    network {
     mode = "bridge"

     port "http" {
       static = 3000
       to = 3000  // Internal port Gogs runs on
     }
  }

    service {
      name = "gogs"
      port = "http"
      provider = "nomad"

      check {
        name     = "alive"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "gogs-server" {
      driver = "docker"

      config {
        image = "petrobubka/my_gogs_image_nomad:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 100
        memory = 256
      }

      volume_mount {
        volume      = "gogs-data"
        destination = "/mnt"
      }
    }

    volume "gogs-data" {
      type   = "host"
      source = "gogs-data"
    }
  }
}
