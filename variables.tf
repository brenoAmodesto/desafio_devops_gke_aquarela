#### Segurando não sei se irei usar ainda
## Placeholder

variable "project" {
  description = "desafio-devops-gke"
  type        = string
  default     = "desafio-devops-gke"
}

variable "node_locations" {
  description = "Zonas adicionais onde os nós serão implantados"
  type        = list(string)
  default     = ["southamerica-east1-b", "southamerica-east1-c"]
}

variable "region" {
  description = "A região onde o cluster será criado"
  type        = string
  default     = "southamerica-east1"
}
