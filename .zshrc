export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
alias ls='ls -G'
eval "$(starship init zsh)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
alias ls='eza --icons --group-directories-first'
alias l='eza -lh --icons --grid --group-directories-first'

# bun completions
[ -s "/Users/mbetamony/.bun/_bun" ] && source "/Users/mbetamony/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
alias config='/usr/bin/git --git-dir=/Users/mbetamony/.cfg/ --work-tree=/Users/mbetamony'
