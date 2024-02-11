# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/trickypr/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway
export _JAVA_AWT_WM_NONREPARENTING=1

# pnpm
export PNPM_HOME="/home/trickypr/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

. "$HOME/.cargo/env"

[ -f "/home/trickypr/.ghcup/env" ] && source "/home/trickypr/.ghcup/env" # ghcup-env

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
	PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export PATH="$PATH:/home/trickypr/go/bin"

if ! type sheldon > /dev/null; then
  cargo binstall sheldon
fi

if ! type starship > /dev/null; then
  cargo binstall starship
fi

eval "$(sheldon source)"
eval "$(starship init zsh)"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

