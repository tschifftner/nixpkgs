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
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
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

    # Bracketed paste deaktivieren – muss in .zshenv, da zsh bracketed paste
    # VOR .zshrc initialisiert.
    # POWERLEVEL9K_INSTANT_PROMPT muss VOR powerlevel10k geladen sein (daher in .zshenv).
    # quiet = Prompt erscheint sofort, Git-Status wird asynchron im Hintergrund geladen.
    envExtra = ''
      export DISABLE_BRACKETED_PASTE=1
      export POWERLEVEL9K_INSTANT_PROMPT=quiet
      export RTK_TELEMETRY_DISABLED=1
      export PI_OFFLINE=1
    '';

    # Add nix
    initContent = ''
      ${builtins.readFile ./zsh/custom-zsh.sh}

      # Orbstack integration
      source ~/.orbstack/shell/init.zsh 2>/dev/null || :

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
