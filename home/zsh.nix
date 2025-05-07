{ pkgs, lib, config, ... }:

{
  programs.zsh = {

    enable = true;

    history.size = 10000;
    history.path = "${config.home.homeDirectory}/zsh/history";

    autosuggestion.enable = true;
    enableCompletion = true;

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.6.4";
          sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
        };
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zdharma";
          repo = "fast-syntax-highlighting";
          rev = "v1.55";
          sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
        };
      }
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = lib.cleanSource ./zsh;
        file = ".p10k.zsh";
      }
    ];

    # Add nix
    initContent = ''
      ${builtins.readFile ./zsh/custom-zsh.sh}

      # Setup bindings for both smkx and rmkx key variants
      # Home
      bindkey '\e[H'  beginning-of-line
      bindkey '\eOH'  beginning-of-line
      # End
      bindkey '\e[F'  end-of-line
      bindkey '\eOF'  end-of-line
    '';
  };
}
