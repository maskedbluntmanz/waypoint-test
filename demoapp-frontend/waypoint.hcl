project = "demoapp-frontend"

app "frontend" {
  labels = {
    "service" = "frontend",
    "env"     = "dev"
  }

  build {
    use "docker-pull" {
        image = "hashicorpdemoapp/frontend"
        tag   = "v0.0.5"
    }
  }

  deploy {
    use "helm" {
      name  = app.name
      chart = "${path.app}/helm"

      // We use a values file so we can set the entrypoint environment
      // variables into a rich YAML structure. This is easier than --set
      values = [
        file(templatefile("${path.app}/helm/values.yaml")),
      ]

      set {
        name  = "image.repository"
        value = "hashicorpdemoapp/frontend"
      }

      set {
        name  = "image.tag"
        value = "v0.0.5"
      }
    }
  }
}