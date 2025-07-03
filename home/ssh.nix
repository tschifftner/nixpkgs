{ pkgs, ... }:

let
  inherit (pkgs) writeText;
  inherit (builtins) readFile;

  ambimaxPubKey = readFile ./ssh/ambimax-hetzner-cloud.pub;
  githubPubKey = readFile ./ssh/github.pub;
  rotaryPubKey = readFile ./ssh/ambimax-rotary.pub;
  tsVpnKey = readFile ./ssh/ts-vpn.pub;
in {
  programs.ssh.extraConfig = "Include config.d/*";

  home.file.".ssh/config.d/ts-ambimax".text = ''
    # Common settings for all hosts
    Host karm ts-k3s-arm ts-k3s nixos ambimax-intern ambimax-intern-k8s-lb monitoring
        User root
        IdentityFile ${writeText "ambimax-hetzner-cloud.pub" ambimaxPubKey}
        IdentitiesOnly yes

    # Specific host settings
    Host ts-vpn ts-proxy
        User root
        HostName 49.12.75.12
        IdentityFile ${writeText "ts-vpn.pub" tsVpnKey}
        IdentitiesOnly yes

    Host github.com
        HostName github.com
        User git
        IdentityFile ${writeText "github.pub" githubPubKey}
        IdentitiesOnly yes
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
