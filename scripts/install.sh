# This expects the fedora i3 image as a base

sudo dnf Thunar alacritty dex-autostart gh git grimshot mpd lua sddm sway waybar xarchiver yarnpkg nodejs neovim firefox

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install neovide

# Installing primary nerd font
(
	cd /tmp
	mkdir nerd_font
	cd nerd_font

	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip
	unzip FiraCode.zip

	sudo mv FiraCode /usr/share/fonts
)

