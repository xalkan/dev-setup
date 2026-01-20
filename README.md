# 🚀 Dev Setup

A high-performance, automated setup script for **CachyOS** (Arch-based). This script configures a complete development environment including Docker, Kubernetes, Node.js, Python, and a fully optimized Zsh/Kitty terminal stack in one go.

## 🛠️ What's Included?

| Category | Tools |
| :--- | :--- |
| **Terminal** | [Kitty](https://sw.kovidgoyal.net/kitty/) (GPU Accelerated) + [Zsh](https://ohmyz.sh/) |
| **Shell Tools** | [Zoxide](https://github.com/ajeetdsouza/zoxide) (cd), [fzf](https://github.com/junegunn/fzf), [eza](https://eza.rocks/) (ls), [bat](https://github.com/sharkdp/bat) (cat) |
| **Cloud/DevOps** | Docker, Docker-Compose, Kubectl, Helm, [K9s](https://k9scli.io/), [Stern](https://github.com/stern/stern) |
| **Languages** | [fnm](https://fnm.vercel.app/) (Node), [uv](https://docs.astral.sh/uv/) (Python) |
| **VCS/UI** | [Lazygit](https://github.com/jesseduffield/lazygit), [Lazydocker](https://github.com/jesseduffield/lazydocker) |
| **Editor/Browser** | VS Code (Bin), Google Chrome |


## 🚀 Quick Start (Installation)

To set up your environment on a fresh CachyOS install, run the following command:

```bash
curl -sL https://raw.githubusercontent.com/xalkan/dev-setup/main/setup.sh | bash
```

### Manual Installation

Alternatively, you can clone the repository and run the script manually:

1. **Clone the repo:**
```bash
git clone https://github.com/xalkan/dev-setup.git && cd dev-setup

```


2. **Make the script executable:**
```bash
chmod +x setup.sh

```


3. **Run the script:**
```bash
./setup.sh

```




## ⚙️ Post-Installation Steps

1. **Restart PC:** Essential to apply the `chsh` (default shell change) and `usermod` (Docker group) permissions.
2. **VS Code:** Open VS Code; the extensions defined in the script will begin installing automatically.
3. **Terminal:** Open **Kitty**. It is pre-configured with a 0.85 opacity and the FiraCode Nerd Font.


## ⌨️ Productivity Shortcuts (Aliases)

The script injects several useful aliases into `.zshrc`:

* `z <dir>` — Smart jump to directories (replaces `cd`).
* `k` — Alias for `kubectl`.
* `kn` — Launch **K9s** (Kubernetes Dashboard).
* `lg` — Launch **Lazygit**.
* `ld` — Launch **Lazydocker**.
* `ls` — Enhanced file listing with icons via **eza**.
* `dcu` — `docker-compose up -d`.


## 📂 Repository Structure

```text
├── setup.sh         # The main installation & configuration script
└── README.md        # Documentation and usage guide

```


## 🔗 Documentation

Detailed documentation for the core tools used in this setup:

* **CachyOS:** [cachyos.org](https://cachyos.org/)
* **Arch Wiki:** [wiki.archlinux.org](https://wiki.archlinux.org/)
* **Nerd Fonts:** [nerdfonts.com](https://www.nerdfonts.com/)
