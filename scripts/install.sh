# This expects the fedora i3 image as a base

sudo dnf install alacritty dex-autostart gh git grimshot lua sddm sway waybar xarchiver yarnpkg nodejs neovim firefox fuzzel

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

cargo install neovide

# Installing primary nerd font
(
	cd /tmp
	mkdir nerd_font
	cd nerd_font

	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip
	
	mkdir FiraCode
	unzip FiraCode.zip -d FiraCode

	sudo mv FiraCode /usr/share/fonts
)

# This is required by nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

