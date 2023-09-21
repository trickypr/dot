# .bashrc

# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=sway
export XDG_CURRENT_DESKTOP=sway

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

alias v=neovide
alias vim=neovide
alias size="stat -c%s"
alias c="code --enable-features=UseOzonePlatform --ozone-platform=wayland ."
alias comp1130-init="/home/trickypr/scripts/comp1130-init.sh"
alias gimmie="sudo dnf install"

export PATH="/home/trickypr/scripts/firefox-nightly:$PATH"

# Enable appindicators
# export XDG_CURRENT_DESKTOP=Unity

. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/home/trickypr/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[ -f "/home/trickypr/.ghcup/env" ] && source "/home/trickypr/.ghcup/env" # ghcup-env


export PATH="$PATH:/app/lib/010editor" #ADDED BY 010 EDITOR
