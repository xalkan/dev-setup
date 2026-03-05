export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git docker kubectl node python zoxide direnv)
source $ZSH/oh-my-zsh.sh

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(uv generate-shell-completion zsh)"
eval "$(starship init zsh)"

# Aliases
alias ls='eza --icons --group-directories-first'
alias cat='bat'
alias k='kubectl'
alias kn='k9s'
alias lg='lazygit'
alias ld='lazydocker'
alias dcu='docker-compose up -d'
alias tldr='tldr' # Tealdeer uses the same command
export PATH="$HOME/.local/bin:$PATH"

# custom functions
uvcreate() {
    mkdir -p "$1" && cd "$1" || return
    uv init
    echo "layout python" > .envrc
    direnv allow
    echo "Successfully initialized $1 with uv and direnv!"
}
