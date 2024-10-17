resource "google_container_cluster" "autopilot_cluster" {
  name     = "meu-cluster-autopilot"
  location = var.region

  # Ativa o modo Autopilot
  enable_autopilot = true

  # Configurações adicionais opcionais
  initial_node_count = 1
  node_locations     = var.node_locations

  # Definir rede para o cluster (opcional)
  network    = "default"
  subnetwork = "default"
}

# Ativa permissões na API
resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

output "endpoint" {
  value = google_container_cluster.autopilot_cluster.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.autopilot_cluster.master_auth.0.cluster_ca_certificate
}

output "kubeconfig" {
  value = <<EOL
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: ${google_container_cluster.autopilot_cluster.master_auth.0.cluster_ca_certificate}
    server: https://${google_container_cluster.autopilot_cluster.endpoint}
  name: gke_${var.project}_${google_container_cluster.autopilot_cluster.location}_${google_container_cluster.autopilot_cluster.name}
contexts:
- context:
    cluster: gke_${var.project}_${google_container_cluster.autopilot_cluster.location}_${google_container_cluster.autopilot_cluster.name}
    user: gke_${var.project}_${google_container_cluster.autopilot_cluster.location}_${google_container_cluster.autopilot_cluster.name}
  name: gke_${var.project}_${google_container_cluster.autopilot_cluster.location}_${google_container_cluster.autopilot_cluster.name}
current-context: gke_${var.project}_${google_container_cluster.autopilot_cluster.location}_${google_container_cluster.autopilot_cluster.name}
kind: Config
preferences: {}
users:
- name: gke_${var.project}_${google_container_cluster.autopilot_cluster.location}_${google_container_cluster.autopilot_cluster.name}
  user:
    auth-provider:
      config:
        cmd-args: config config-helper --format=json
        cmd-path: gcloud
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
EOL
}
