{ pkgs, ... }:

{
  # Kubernetes and container orchestration tools
  home.packages = with pkgs; [
    kubectl               # Command line tool for interacting with Kubernetes clusters
    kubectx               # Switch between Kubernetes clusters easily
    kustomize             # Tool for customizing Kubernetes YAML configurations
    kubernetes-helm       # Helm package manager for Kubernetes
  ];
}
