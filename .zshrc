## Ivy's zshrc for macOS :3

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
