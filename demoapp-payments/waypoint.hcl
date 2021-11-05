project = "demoapp-payments"

app "payments" {
  labels = {
    "service" = "payments",
    "env"     = "dev"
  }

  build {
    use "docker-pull" {
        image = "hashicorpdemoapp/payments"
        tag   = "v0.0.12"
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
        value = "hashicorpdemoapp/payments"
      }

      set {
        name  = "image.tag"
        value = "v0.0.12"
      }
    }
  }
}