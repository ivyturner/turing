## Ivy's zshrc for macOS :3

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found


fpath+=~/turing/.zfunc

# setup brew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ENV_HINTS=1

# setup nvim
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"

nvims() {
  local version
  version=$(bob list-remote | awk '{print $1}' | fzf --prompt="Select Neovim version: " --height=40% --reverse)
  if [[ -n "$version" ]]; then
    if ! bob list | grep -q "^$version"; then
      echo "Installing $version..."
      bob install "$version"
    fi
    bob use "$version"
    echo "Switched to Neovim version: $version"
  else
    echo "No version selected."
  fi
}

# deno
. "/Users/i/.deno/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "/Users/i/.bun/_bun" ] && source "/Users/i/.bun/_bun"

# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
fi

# opencode
export PATH=/Users/i/.opencode/bin:$PATH

## ENV VARIABLES
export EDITOR="nvim"


## Aliases

alias ,reload="source ~/turing/.zshrc"
alias ,edit="nvim ~/turing/.zshrc && ,reload"

# editors

alias {v,vi,vim}=nvim

# Starship prompt
eval "$(starship init zsh)"

# cd but better

eval "$(zoxide init zsh --cmd cd)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias cl=clear
