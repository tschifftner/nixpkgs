{ config, lib, pkgs, ... }:

{
  # Configure what vaults can be used on command line
  home.file.".config/1Password/ssh/agent.toml".source = ./1Password/agento.toml;

  home.file.".kube/kubectl-wrapper" = {
    source = ./1Password/kubectl-wrapper.sh;
    executable = true;
  };

  home.file.".supabase/config.toml".text = ''
    [analytics]
    enabled = false
  '';
}
