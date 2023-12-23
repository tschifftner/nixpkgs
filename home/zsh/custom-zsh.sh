#!/bin/bash
# export PATH="/Users/ts/.nix-profile/bin:/etc/profiles/per-user/ts/bin:/run/current-system/sw/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:/etc/profiles/per-user/ts/bin:/run/current-system/sw/bin:$PATH"

# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
    # shellcheck source=/dev/null
    . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

# Set title for terminal tabs
precmd() {
    local title

    # Get the current working directory, replacing the home directory with ~
    title=$(echo "${PWD/#$HOME/~}" | tail -c 25)

    # Set the window title
    print -Pn "\e]0;$title\a"
}

# Symlink iCloud
if [[ ! -L "$HOME/iCloud" ]]; then
    ln -s "$HOME/Library/Mobile Documents/com~apple~CloudDocs" "$HOME/iCloud"
fi

# 1Password Cli
#eval "$(op signin --account my)" && eval "$(op signin --account ambimax)"
