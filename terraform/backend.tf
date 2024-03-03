terraform {
  cloud {
    organization = "ilyasilkin"

    workspaces {
      name = "hexlet-01-workspace"
    }
  }
}