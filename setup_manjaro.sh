#!/usr/bin/env bash
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm base-devel neofetch docker ruby tlp git neovim python python-pip

get_distro_name() {
	local distro=$(awk  -F= '$1=="ID" { print $2 ;}' /etc/os-release)
	echo "$distro"
}

distro=$(get_distro_name)
if [ "$distro" == "arch" ]; then
	echo "Doing arch things"
	
	sudo -u $USER git clone https://aur.archlinux.org/yay-git.git
	cd yay-git
	sudo -u $USER makepkg -si --noconfirm
	cd ..
	rm -rf yay-git
	
	sudo -u $USER git clone https://aur.archlinux.org/nvm.git
	cd nvm
	sudo -u $USER makepkg -si --noconfirm
	rm -rf nvm
	
	sudo pacman -S --noconfirm zsh zsh-completions zsh-theme-powerlevel10k
	sudo -u $USER chsh -s /bin/zsh
	sudo -u $USER echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc
	
	sudo -u $USER git clone https://aur.archlinux.org/snapd.git
	cd snapd
	sudo -u $USER makepkg -si --noconfirm
	cd ..
	rm -rf snapd
	sudo systemctl enable --now snapd.socket
	sudo ln -s /var/lib/snapd/snap /snap
	sudo snap install snapd
fi 

sudo usermod -aG docker ${USER}
sudo systemctl enable docker.service
sudo systemctl enable tlp --now

sudo snap install eclipse --edge --classic
sudo snap install intellij-idea-ultimate --classic
sudo snap install code --classic
sudo snap install microk8s --classic
sudo snap install insomnia

sudo usermod -aG microk8s ${USER}

sudo -u $USER echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.zshrc
sudo -u $USER echo 'source /usr/share/nvm/init-nvm.sh' >> ~/.bashrc
sudo -u $USER nvm install 14

# Npm
sudo -u $USER mkdir ~/.npm-global
sudo -u $USER npm config set prefix '~/.npm-global'
sudo -u $USER echo 'PATH=~/.npm-global/bin:$PATH' >> ~/.zshenv
sudo -u $USER echo 'PATH=~/.npm-global/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile
sudo -u $USER npm install -g yarn

# Yarn
sudo -u $USER mkdir ~/.yarn-global
sudo -u $USER yarn config set global-folder ~/.yarn-global
sudo -u $USER yarn config set prefix ~/.yarn-global
sudo -u $USER echo 'export PATH="$PATH:$(yarn global bin)"' >> ~/.zshenv
sudo -u $USER echo 'export PATH="$PATH:$(yarn global bin)"' >> ~/.bash_profile

sudo -u $USER pip3 install --user neovim 

sudo -u $USER echo "export DOTNET_CLI_TELEMETRY_OPTOUT=1" >> ~/.zshrc
sudo -u $USER echo "export DOTNET_CLI_TELEMETRY_OPTOUT=1" >> ~/.bashrc
sudo -u $USER curl -s 'https://get.sdkman.io' | bash

echo "autoload -Uz zsh-newuser-install"
echo "zsh-newuser-install -f"
