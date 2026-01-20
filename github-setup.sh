#!/bin/bash

# --- 0. SET IDENTITY ---
# Usage: ./github_setup.sh "email@example.com" "Your Name"
GIT_EMAIL=${1:-""}
GIT_NAME=${2:-""}

if [ -z "$(git config --global user.email)" ] && [ -z "$GIT_EMAIL" ]; then
    read -p "Enter your GitHub Email: " GIT_EMAIL
    read -p "Enter your GitHub Name: " GIT_NAME
fi

[ -n "$GIT_EMAIL" ] && git config --global user.email "$GIT_EMAIL"
[ -n "$GIT_NAME" ] && git config --global user.name "$GIT_NAME"

# --- 1. INSTALL & AUTH ---
paru -S --noconfirm github-cli

echo "🔑 Authenticating with GitHub..."
# Browser login happens here. 
# Once this is done, the script has permission to do the rest.
gh auth login -p https -w

# --- 2. KEY GENERATION & SIGNING SETUP ---
KEY_NAME="github_signing_key"
KEY_PATH="$HOME/.ssh/$KEY_NAME"

if [ ! -f "$KEY_PATH" ]; then
    ssh-keygen -t ed25519 -C "$(git config --global user.email)" -f "$KEY_PATH" -N ""
    
    # This command uses the 'gh' session to upload the key automatically
    gh ssh-key add "${KEY_PATH}.pub" --title "xalkan.dev.$(hostname)" --type signing
fi

# --- 3. APPLY CONFIGS ---
gh auth setup-git
git config --global gpg.format ssh
git config --global user.signingkey "${KEY_PATH}.pub"
git config --global commit.gpgsign true

# SSH Identity Mapping
mkdir -p ~/.ssh
if ! grep -q "$KEY_NAME" ~/.ssh/config 2>/dev/null; then
    cat << EOF >> ~/.ssh/config

Host github.com
    HostName github.com
    User git
    IdentityFile $KEY_PATH
EOF
fi

echo "✨ All set! Your commits are now automatically signed and verified."
