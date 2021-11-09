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

app "product-api-db" {
  labels = {
    "service" = "product-api-db",
    "env"     = "dev"
  }

  url {
    auto_hostname = false
  }

  build {}
  // build {
  //   use "docker-pull" {
  //     image = "hashicorpdemoapp/product-api-db"
  //     tag   = "v0.0.17"
  //   }
  // }

  deploy {
    use "helm" {
      name  = app.name
      chart = "${path.app}/product-api-db/helm"

      values = [
        file(templatefile("${path.app}/product-api-db/helm/values.yaml")),
      ]
    }
  }
}

app "product-api" {
  labels = {
    "service" = "product-api",
    "env"     = "dev"
  }

  url {
    auto_hostname = false
  }

  build {
    use "docker-pull" {
      image = "hashicorpdemoapp/product-api"
      tag   = "v0.0.17"
    }
  }

  deploy {
    use "helm" {
      name  = app.name
      chart = "${path.app}/product-api/helm"

      values = [
        file(templatefile("${path.app}/product-api/helm/values.yaml")),
      ]
    }
  }
}

app "payments" {
  labels = {
    "service" = "payments",
    "env"     = "dev"
  }

  url {
    auto_hostname = false
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
      chart = "${path.app}/payments/helm"

      values = [
        file(templatefile("${path.app}/payments/helm/values.yaml")),
      ]
    }
  }
}

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
      chart = "${path.app}/frontend/helm"

      values = [
        file(templatefile("${path.app}/frontend/helm/values.yaml")),
      ]
    }
  }
}