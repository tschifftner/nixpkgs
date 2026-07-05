{ pkgs, ... }:

let
  inherit (pkgs) writeText;
  inherit (builtins) readFile;

  ambimaxPubKey = readFile ./ssh/ambimax-hetzner-cloud.pub;
  githubPubKey = readFile ./ssh/github.pub;
  rotaryPubKey = readFile ./ssh/ambimax-rotary.pub;
  hetznerPubKey = readFile ./ssh/hetzner.pub;
  tsVpnKey = readFile ./ssh/ts-vpn.pub;
in {
  programs.ssh.extraConfig = "Include config.d/*";

  home.file.".ssh/config.d/ts".text = ''
    # Hetzner defaults (shared config)
    Host ws1 ws1-tunnel ws1-tty ws2-tty
      User ts
      HostName 167.233.192.218
      IdentityFile ${writeText "hetzner.pub" hetznerPubKey}
      IdentitiesOnly yes

    # Die interaktive Erweiterung NUR für das Terminal
    Host ws1-tty 
      RequestTTY yes
      # RemoteCommand tmux attach-session -t ts || tmux new-session -s ts
      RemoteCommand tmux new-session -A -s dev -c ~/ws

    # Hetzner ws2 defaults (shared config)
    Host ws2 ws2-tty
      User ts
      HostName 204.168.205.240
      IdentityFile ${writeText "hetzner.pub" hetznerPubKey}
      IdentitiesOnly yes

    # Die interaktive Erweiterung NUR für das Terminal
    Host ws2-tty
      RequestTTY yes
      # RemoteCommand tmux attach-session -t ts || tmux new-session -s ts
      RemoteCommand tmux new-session -A -s dev -c ~/ws

    Host ws1-tunnel
     # LocalForward 5432 localhost:5432
     # LocalForward 5672 localhost:5672
     # LocalForward 6379 localhost:6379
     # LocalForward 8000 localhost:8000
     LocalForward 8000 127.0.0.1:8000
     # LocalForward 9000 localhost:9000
     # LocalForward 9001 localhost:9001
     # LocalForward 15672 localhost:15672
     # LocalForward 5174 localhost:5173  
  '';

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
