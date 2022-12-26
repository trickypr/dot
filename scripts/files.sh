# =============================================================================
# Scripting

# https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script
scripts_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
dot_dir=$(dirname $scripts_dir)

function folder {
	local name=$1
	local folder=$2
	local output=$3

	echo "Linking $name"

	rm -rf $output
	echo "  => Cleaned output"

	mkdir -p $(dirname $output)
	ln -s $folder $output 
	echo "  => Linked"
	echo ""
}

function root_file {
	local name=$1
	local source=$2
	local output=$3

	echo "Copying $name"

	sudo rm $output
	echo "  => Cleaned output"

	sudo mkdir -p $(dirname $output)
	sudo cp $source $output
	echo "  => Copied"
	echo ""
}


function file {
	local name=$1
	local source=$2
	local output=$3

	echo "Copying $name"

	rm $output
	echo "  => Cleaned output"

	mkdir -p $(dirname $output)
	ln -s $source $output
	echo "  => Copied"
	echo ""
}

# =============================================================================
# Dot files

root_file "Font config" "$dot_dir/fonts_local.conf" "/etc/fonts/local.conf"
root_file "Background Image" "$dot_dir/romb.png" "/usr/share/backgrounds/romb.png"

file "Git config" "$dot_dir/.gitconfig" "$HOME/.gitconfig"
file "Bash config" "$dot_dir/.bashrc" "$HOME/.bashrc"

folder Neovim "$dot_dir/nvim" "$HOME/.config/nvim"
folder Alacritty "$dot_dir/alacritty" "$HOME/.config/alacritty"
folder Dunst "$dot_dir/dunst" "$HOME/.config/dunst"
folder Fuzzel "$dot_dir/fuzzel" "$HOME/.config/fuzzel" 
folder Sway "$dot_dir/sway" "$HOME/.config/i3" 
folder "Sway Lock" "$dot_dir/swaylock" "$HOME/.config/swaylock"
folder Waybar "$dot_dir/waybar" "$HOME/.config/waybar"
folder Waybar "$dot_dir/kitty" "$HOME/.config/kitty"


