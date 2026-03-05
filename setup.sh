#!/bin/bash

# --- 1. BOOTSTRAP PARU ---
if ! command -v paru &> /dev/null; then
    sudo pacman -S --needed base-devel git && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si --noconfirm && cd ..
fi

echo "🚀 Fixing conflicts and starting setup..."

# --- 2. INSTALL PACKAGES ---
# Switched 'tldr' to 'tealdeer' (faster Rust version) to avoid the conflict
paru -S --noconfirm \
    google-chrome kitty visual-studio-code-bin \
    docker docker-compose kubectl helm k9s stern \
    lazygit lazydocker tealdeer \
    python-uv fnm-bin github-cli \
    zsh zsh-autosuggestions zsh-syntax-highlighting \
    zoxide fzf eza bat ripgrep jq direnv \
    ttf-firacode-nerd \
    opencode starship

# --- 3. SHELL SETUP ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

if [ "$SHELL" != "/usr/bin/zsh" ]; then
    sudo chsh -s /usr/bin/zsh $USER
fi

# --- 4. FIXING FNM & NODE ---
# Explicitly set path so the script can see fnm immediately after install
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

if command -v fnm &> /dev/null; then
    fnm install --lts
    fnm use --lts
else
    echo "⚠️ fnm not found in path, skipping node install. It will work after restart."
fi

# --- 5. CONFIGURATION INJECTION (.zshrc) ---
# --- 5. CONFIGURATION INJECTION (.zshrc) ---
if [ -f "$PWD/dotfiles/.zshrc" ]; then
    if [ -f "$HOME/.zshrc" ]; then
        echo "⚠️  $HOME/.zshrc already exists. Backing up to $HOME/.zshrc.bak."
        mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    fi
    cp "$PWD/dotfiles/.zshrc" "$HOME/.zshrc"
    echo "✅ Copied dotfiles/.zshrc to $HOME/.zshrc."
else
    echo "❌ dotfiles/.zshrc not found. Skipping .zshrc setup."
fi

# --- 6. KITTY CONFIG ---
mkdir -p ~/.config/kitty
cat << 'EOF' > ~/.config/kitty/kitty.conf
font_family FiraCode Nerd Font
font_size 11.0
background_opacity 0.85
confirm_os_window_close 0
shell zsh
EOF

# --- 7. ADVANCED PRODUCTIVITY TOOLS ---
# Install Tmux, Tmuxinator and Devbox
paru -S --noconfirm tmux tmuxinator
curl -fsSL https://get.jetpack.io/devbox | bash

# Ensure Tmuxinator config directory exists
mkdir -p ~/.config/tmuxinator

# Add Tmuxinator Editor environment variable to .zshrc
echo 'export EDITOR="code"' >> ~/.zshrc

# --- 7.1 STARSHIP PROMPT SETUP ---
mkdir -p ~/.config
cat << 'EOF' > ~/.config/starship.toml
[character]
success_symbol = "[❯](bold green)"
EOF

# Add Starship init to .zshrc if not present
if ! grep -q 'starship init zsh' ~/.zshrc; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
    echo "✅ Added Starship prompt initialization to .zshrc."
fi

# --- 7.2 OPENCODE ALIAS SETUP ---
if ! grep -q 'alias oc=' ~/.zshrc; then
    echo 'alias oc="opencode"' >> ~/.zshrc
    echo "✅ Added 'oc' alias for opencode to .zshrc."
fi

# --- 8. DOCKER FIXES ---
# Ensure the docker group exists and the service is recognized
sudo groupadd -f docker
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl start docker.service

echo "✨ FIXED! Please log out and back in for changes to take effect."
