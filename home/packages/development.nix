{ config, lib, pkgs, ... }:

let
  pnpmHome = "${config.home.homeDirectory}/.local/share/pnpm";
  pnpmBinDir = "${pnpmHome}/bin";
  pnpmGlobalDir = "${config.home.homeDirectory}/Library/pnpm-global";
  pnpmStoreDir = "${config.home.homeDirectory}/Library/pnpm-store";
  npmPrefix = "${config.home.homeDirectory}/.local/share/npm";
in

{
  # Development tools and programming languages
  home.packages = with pkgs; [
    # Core development
    nodejs                  # Node.js runtime
    pnpm                    # Package manager for JavaScript
    # Python runtime with pytest for running Python tests
    (python312.withPackages (ps: with ps; [ pytest pyyaml uv ]))
    typescript              # TypeScript compiler
    concurrently           # Run commands concurrently
    biome                  # JavaScript and TypeScript linter, formatter, and bundler
    
    # Source code analysis
    cloc                   # Source code line counter
    
    # Version control
    github-copilot-cli    # GitHub Copilot CLI
    agent-browser         # Browser Automation MCP
    
    # API and cloud tools
    s3cmd                 # Command line tool for managing Amazon S3 and CloudFront
    yq                    # Command-line YAML processor, similar to jq
    
    # Shell scripting
    shfmt                 # Shell script formatter
    
    # Container tools
    docker                # Container runtime
    docker-compose        # Tool for defining and running multi-container Docker applications
  ];

  # Make `pnpm -g` install into user-writable directories instead of the Nix store.
  home.sessionVariables.PNPM_HOME = pnpmHome;
  home.sessionVariables.NPM_CONFIG_PREFIX = npmPrefix;
  home.sessionVariables.NPM_CONFIG_USERCONFIG = "${config.home.homeDirectory}/.npmrc";
  home.sessionPath = [ pnpmBinDir "${config.home.homeDirectory}/.local/bin" "${npmPrefix}/bin" ];

  # Nur `prefix` im .npmrc – das ist der einzige key, den npm + pnpm gleichermassen verstehen.
  # pnpm-spezifische Optionen (global-bin-dir, global-dir, store-dir) werden über PNPM_HOME
  # gesteuert und würden nur npm-Warnings provozieren.
  home.file.".npmrc".text = ''
    prefix=${npmPrefix}
  '';

  home.activation.createPnpmDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${pnpmHome}" "${pnpmBinDir}" "${pnpmGlobalDir}" "${pnpmStoreDir}" "${npmPrefix}"
  '';
}
