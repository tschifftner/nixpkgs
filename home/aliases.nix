{ self, pkgs, lib, config, darwin, ... }:

let
  profileBin = "/etc/profiles/per-user/${config.home.username}/bin";
  # caskPresent = cask: lib.any (x: x.name == cask) self.homebrew.casks;
  # opInstalled = (caskPresent "1password-cli" && config ? home-manager);
in {
  home.shellAliases = with pkgs; {

    "..." = "cd ../..";
    ".." = "cd ..";
    ":q" = "exit";

    cat = "${bat}/bin/bat";
    du = "${du-dust}/bin/dust";
    g = "${git}/bin/git";
    wget = "${pkgs.wget}/bin/wget";

    iCloud = "~/Library/Mobile\\ Documents/com~apple~CloudDocs";

    context = "source ~/.kube/kubectl-wrapper";
    kubectl = "context && ${profileBin}/kubectl $@";
    kubectx = "context && ${profileBin}/kubectx $@";
    k9s = "context && ${profileBin}/k9s $@";
    k = "kubectl";
    kx = "kubectx";

    # } // lib.optionalAttrs opInstalled {
    #   gh = "op plugin run -- gh";
    #   nixpkgs-review = "op run -- nixpkgs-review";
  };

}

