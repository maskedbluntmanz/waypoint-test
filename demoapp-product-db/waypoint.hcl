project = "demoapp-product-api-db"

app "product-api-db" {
  labels = {
    "service" = "public-api",
    "env"     = "dev"
  }

  build {
    use "docker-pull" {
        image = "hashicorpdemoapp/product-api-db"
        tag   = "v0.0.17"
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
        value = "hashicorpdemoapp/product-api-db"
      }

      set {
        name  = "image.tag"
        value = "v0.0.17"
      }
    }
  }
}