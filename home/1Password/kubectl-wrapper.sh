#!/bin/bash
#
# This script loads all kubeconfig files from 1Password
# and saves them in tmp files. They are then combined
# into a single tmp file for usage. After reboot the
# file should be gone and will be regenerated if required.

if [ -n "$KUBECONFIG" ]; then
    # Return if env variable is already defined
    return
fi

# Function to set KUBECONFIG with multiple kubeconfig files
set_kubeconfigs() {
    echo "$@" | tr ' ' ':'
}

# Function to cleanup temporary files
cleanupTmpFiles() {
    for file in "${kubeconfig_files[@]}"; do
        rm -f "$file"
    done
}

destroyKubeConfig() {
    rm -f "$final_kubeconfig"
}

# Fetch all items with tag 'kubernetes-context' in JSON format
contexts_json=$(op item list --tags kubernetes-context --categories DOCUMENT --format json)

# Check if any contexts are found
if [ -z "$contexts_json" ]; then
    echo "No Kubernetes contexts found with tag 'kubernetes-context'"
    exit 1
fi

# Array to hold all temporary kubeconfig files
kubeconfig_files=()

# Loop through each context using JSON output
for uuid in $(echo "$contexts_json" | jq -r '.[].id'); do
    echo "UUID: $uuid"
    #kubeconfig=$(op item get "$uuid" --fields "notesPlain")
    kubeconfig=$(op document get "$uuid")

    # Continue if kubeconfig is empty
    [ -z "$kubeconfig" ] && continue

    # Create temporary file for kubeconfig
    temp_kubeconfig=$(mktemp)

    # Write the kubeconfig to the temporary file
    echo "$kubeconfig" >"$temp_kubeconfig"

    # Add file to array
    kubeconfig_files+=("$temp_kubeconfig")
done

# Set KUBECONFIG environment variable with filenames of temp files
KUBECONFIG=$(set_kubeconfigs "${kubeconfig_files[@]}")
export KUBECONFIG

# Flatten for kubectx
final_kubeconfig=$(mktemp)
kubectl config view --merge --flatten >"$final_kubeconfig"
cleanupTmpFiles

KUBECONFIG="$final_kubeconfig"
export KUBECONFIG

echo "KUBECONFIG is set for the current session. Files: $KUBECONFIG"

# Set trap for cleanup on the calling shell
#trap destroyKubeConfig EXIT
