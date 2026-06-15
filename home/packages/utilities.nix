{ lib, pkgs, ... }:

{
  # Basic CLI utilities and system tools
  home.packages = lib.attrValues ({
    supabase-cli = pkgs.callPackage ../supabase-cli.nix { };

    # Basic CLI tools
    inherit (pkgs)
      bandwhich           # Display current network utilization by process
      coreutils           # The GNU Core Utilities
      curl                # Transferring files with URL syntax
      dust                # Fancy version of `du`
      fd                  # Fancy version of `find`
  # mdcat               # Display markdown files
  # NOTE: mdcat currently fails to build due to a strict-deny warnings
  # lint in its pulldown-cmark-mdcat dependency. Commented out to allow
  # system activation to proceed; re-enable after pinning or patching.
      go-task             # Task runner (used by Taskfile.yml)
      mosh                # Wrapper for `ssh` that better and not dropping connections
      unrar               # Extract RAR archives
      upterm              # Secure terminal sharing
      wget                # Stable wget instead of wget2 (build issues)
      xz                  # Extract XZ archives
    ;
    
  } // lib.optionalAttrs pkgs.stdenv.isDarwin {
    inherit (pkgs) m-cli; # Useful macOS CLI commands
  });
}
