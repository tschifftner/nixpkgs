{ pkgs, ... }:

let
  inherit (pkgs) writeText;
  inherit (builtins) readFile;

  ambimaxPubKey = readFile ./ssh/ambimax-hetzner-cloud.pub;
  tsVpnKey = readFile ./ssh/ts-vpn.key;
in {
  programs.ssh.extraConfig = "Include config.d/*";

  home.file.".ssh/config.d/ts-ambimax".text = ''
    # Common settings for all hosts
    Host karm ts-k3s-arm ts-k3s nixos ambimax-intern ambimax-intern-k8s-lb monitoring
        User root
        IdentityFile ${writeText "ambimax-hetzner-cloud.key" ambimaxPubKey}
        IdentitiesOnly yes

    # Specific host settings
    Host ts-vpn ts-proxy
        HostName 49.12.75.12
        IdentityFile ${writeText "ts-vpn.key" tsVpnKey}

    Host nixos
        HostName 78.47.137.218

    Host ts-proxy
        HostName 167.235.158.223

    Host karm ts-k3s-arm
        HostName 159.69.124.37

    Host monitoring
        HostName 167.235.243.187

    Host ts-k3s
        HostName 168.119.111.45

    Host ambimax-intern
    HostName 206.189.57.97

    Host ambimax-intern-k8s-lb
        HostName 206.189.57.97
  '';

  home.file.".ssh/config.d/global".text = ''
    Host *
        ServerAliveInterval 60
        ControlMaster auto
        ControlPath /tmp/ssh-%r@%h:%p
  '';

  home.file.".ssh/config.d/gitpod".text = ''
    Host *.gitpod.io
        ForwardAgent yes
  '';
}
