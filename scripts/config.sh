# This is the file that ties everything together. It sets up dnf before installing everything
# then it calls the config scripts

echo "fastestmirror=1" | sudo tee -a /etc/dnf/dnf.conf
sudo dnf clean all

./files.sh

sudo systemctl disable lightdm
sudo systemctl enable sddm

sudo dnf remove lightdm i3

./install.sh
