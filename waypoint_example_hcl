project = "hashicups"

app "public-api" {
  labels = {
    "service" = "public-api",
    "env"     = "dev"
  }

  url {
    // Disable the Waypoint URL service from generating a name
    // for this app
    auto_hostname = false
  }

  build {
    use "docker-pull" {
      image = "hashicorpdemoapp/public-api"
      tag   = "v0.0.5"
      disable_entrypoint = true
    }
  }

  deploy {
    use "helm" {
      name  = app.name
      chart = "${path.app}/public-api/helm"

      // We use a values file so we can set the entrypoint environment
      // variables into a rich YAML structure. This is easier than --set
      values = [
        file(templatefile("${path.app}/public-api/helm/values.yaml")),
      ]
    }
  }
}