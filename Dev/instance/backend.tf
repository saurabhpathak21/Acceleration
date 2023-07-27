terraform {
  cloud {
    organization = "New-acceleration"

    workspaces {
      name = "acceleration-dev"
    }
  }
}