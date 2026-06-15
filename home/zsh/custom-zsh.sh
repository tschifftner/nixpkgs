#!/bin/bash

# PATH – nur die Zusätze, die nicht schon von nix-darwin gesetzt werden
export PATH="$HOME/.local/bin:$HOME/.local/share/pnpm/bin:$PATH"

# PNPM / NPM Config
export PNPM_HOME="$HOME/.local/share/pnpm"
export NPM_CONFIG_PREFIX="$HOME/.local/share/npm"
export NPM_CONFIG_USERCONFIG="$HOME/.npmrc"

# Brew shellenv nur sourcen wenn brew noch nicht im PATH ist
if ! command -v brew &>/dev/null && [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Terminal title
precmd() {
    print -Pn "\e]0;${PWD/#$HOME/~}\a"
}

# iCloud symlink (einmalig)
[[ ! -L "$HOME/iCloud" ]] && ln -sf "$HOME/Library/Mobile Documents/com~apple~CloudDocs" "$HOME/iCloud"

# 1Password SSH agent
[[ -S "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]] &&
    export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
