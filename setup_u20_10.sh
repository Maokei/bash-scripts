#!/usr/bin/env bash
# Ubuntu 22.10 install script

# Check arguments
for i in "$@" ; do
    if [[ $i == "gnome" ]] ; then
        echo "Setting gnome desktop"
        GNOME=true
        break
    fi
    if [[ $i == "kde" ]] ; then
        echo "Setting kde desktop"
        KDE=true
        break
    fi
    if [[ $i == "zsh" ]] ; then
        echo "Setting zsh shell"
        ZSH=true
        break
    fi
done

sudo add-apt-repository -y universe

sudo apt update
sudo apt install -y flatpak gnome-software gnome-software-plugin-flatpak 
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common gnupg ca-certificates lsb-release
sudo add-apt-repository -y ppa:remmina-ppa-team/remmina-next

## Adding flathub repo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Docker engine
sudo mkdir -p /etc/apt/keyrings
sudo -u $USER curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo -u $USER echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update
sudo apt upgrade

# Install snaps
sudo snap install dotnet-sdk --classic
sudo snap install go --classic
sudo snap install intellij-idea-community --classic
sudo snap install eclipse --edge --classic
sudo snap install slack --classic
sudo snap install kotlin --classic
sudo snap install rustup --classic
sudo snap install robo3t-snap
sudo snap install postman
sudo snap install insomnia
sudo snap install ubuntu-make --classic
sudo snap install code --classic
sudo snap install ripgrep --classic
sudo snap install microk8s --classic
sudo snap install telegram-desktop
sudo snap install blender --classic
sudo snap install spotify

# Install stuff
sudo apt install -y git neofetch pavucontrol \
synaptic peek feh qgis brave-browser \
tmux vlc zeal gimp krita \
htop tree ranger neovim p7zip p7zip-full p7zip-rar powerline fonts-powerline meld guake \
ubuntu-restricted-extras gcc g++ make python3-pip wireshark brave-browser \
docker-ce docker-ce-cli containerd.io docker-compose-plugin gpg rustc libfuse2

#sudo usermod -s /usr/bin/zsh $(whoami)
#sudo -u $USER echo "source /usr/share/powerlevel9k/powerlevel9k.zsh-theme" >> ~/.zshrc
#sudo -u $USER echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
#sudo -u $USER echo "SAVEHIST=500" >> ~/.zshrc
#sudo -u $USER echo "HISTFILE=~/.zsh_history" >> ~/.zshrc
#sudo -u $USER echo "if [ -f ~/.bash_aliases ]; then" >> ~/.zshrc
#sudo -u $USER echo "    . ~/.bash_aliases" >> ~/.zshrc
#sudo -u $USER echo "fi" >> ~/.zshrc

#groups
sudo usermod -aG docker ${USER}
sudo usermod -aG microk8s ${USER}

sudo -u $USER echo "if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then" >> ~/.bashrc
sudo -u $USER echo "    source /usr/share/powerline/bindings/bash/powerline.sh" >> ~/.bashrc
sudo -u $USER echo "fi" >> ~/.bashrc

sudo -u $USER curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
source ~/.profile
sudo -u $USER nvm install node
sudo -u $USER source ~/.bashrc

sudo -u $USER wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
wget -c https://zoom.us/client/latest/zoom_amd64.deb \
wget -c https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb \
wget -c https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb

sudo dpkg -i ./google-chrome*.deb
sudo dpkg -i ./zoom_amd64.deb
sudo dpkg -i ./steam*.deb
sudo dpkg -i ./minikube_latest_amd64.deb
rm *.deb
sudo apt install -f -y

# Inode watch
sudo echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf
sudo sysctl -p --system

# VS code extensions
sudo -u $USER code --install-extension ms-python.anaconda-extension-pack \
code --install-extension PeterJausovec.vscode-docker \
code --install-extension johnpapa.angular-essentials \
code --install-extension ms-vscode.cpptools \
code --install-extension msjsdiag.debugger-for-chrome \
code --install-extension HookyQR.beautify \
code --install-extension ritwickdey.LiveServer \
code --install-extension jawandarajbir.react-vscode-extension-pack \
code --install-extension xabikos.JavaScriptSnippets \
code --install-extension vscjava.vscode-java-pack \
code --install-extension jhipster \
code --install-extension GabrielBB.vscode-lombok \
code --install-extension ms-dotnettools.csharp \
code --install-extension geequlim.godot-tools \
code --install-extension rust-lang.rust \
code --install-extension mathiasfrohlich.Kotlin \
code --install-extension Unity.unity-debug \

sudo -u $USER pip3 install --user neovim

# Joplin
# sudo -u $USER wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash
flatpak install flathub net.cozic.joplin_desktop

# Cura
flatpak install flathub com.ultimaker.cura

# bash alias
sudo -u $USER touch ~/.bash_aliases
sudo -u $USER echo "alias untar='tar -zxvf '" >> ~/.bash_aliases
sudo -u $USER echo "alias www='python -m SimpleHTTPServer 8000'" >> ~/.bash_aliases
sudo -u $USER echo "alias showGoverners='cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors'" >> ~/.bash_aliases
sudo -u $USER echo "alias lowPerf='echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'" >> ~/.bash_aliases
sudo -u $USER echo "alias highPerf='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'" >> ~/.bash_aliases
sudo -u $USER echo "alias kwinRe='kwin_x11 --replace &'" >> ~/.bash_aliases
sudo -u $USER echo 'neofetch' >> ~/.bash_aliases

# Desktop specific
if [ -n "$GNOME" ]; then
	echo "Desktop: Gnome"
	# sudo -u $USER gsettings set org.gnome.desktop.interface enable-animations false
	# sudo -u $USER gsettings set org.gnome.desktop.background show-desktop-icons false
	# tracker-miner-fs
	sudo -u $USER gsettings set org.freedesktop.Tracker.Miner.Files crawling-interval -2  
	sudo -u $USER gsettings set org.freedesktop.Tracker.Miner.Files enable-monitors false
	sudo -u $USER tracker reset --hard
fi

# ZSH
if [ -n "$ZSH" ]; then
	echo "ZSH"
	sudo apt install -y zsh zsh-syntax-highlighting zsh-theme-powerlevel9k
	# chsh -s /usr/bin/zsh
fi

#Turnoff dotnet core telemetry
sudo -u $USER echo "export DOTNET_CLI_TELEMETRY_OPTOUT=1" >> ~/.bashrc

# sdkman
sudo -u $USER curl -s 'https://get.sdkman.io' | bash
#sdkman zsh
#sudo -u $USER echo "export SDKMAN_DIR=\"home/${USER}/sdkman\"" >> ~/.zshrc
#sudo -u $USER echo "[[ -s \"/home/${USER}/.sdkman/bin/sdkman-init.sh\" ]] && source \"/home/${USER}/.sdkman/bin/sdkman-init.sh\"" >> ~/.zshrc

#secure mysql
#sudo mysql_secure_installation

echo "Installation complete"
echo "========================================="
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
echo "░░░░░░░░▄▄▄▀▀▀▄▄███▄░░░░░░░░░░░░░░░░░░░░░" 
echo "░░░░░░▄▀▀░░░░░░░▐░▀██▌░░░░░░░░░░░░░░░░░░░" 
echo "░░░░▄▀░░░░▄▄███░▌▀▀░▀█░░░░░░░░░░░░░░░░░░░" 
echo "░░▄█░░▄▀▀▒▒▒▒▒▄▐░░░░█▌░░░░░░░░░░░░░░░░░░░"
echo "░▐█▀▄▀▄▄▄▄▀▀▀▀▌░░░░░▐█▄░░░░░░░░░░░░░░░░░░" 
echo "░▌▄▄▀▀░░░░░░░░▌░░░░▄███████▄░░░░░░░░░░░░░" 
echo "░░░░░░░░░░░░░▐░░░░▐███████████▄░░░░░░░░░░" 
echo "░░░░░le░░░░░░░▐░░░░▐█████████████▄░░░░░░░"
echo "░reboot toucan░▀▄░░░▐██████████████▄ ░░░░"
echo "░░░░░░has░░░░░░░░▀▄▄████████████████▄░░░░"
echo "░░░░░arrived░░░░░░░░░░░░█▀██████░░░░░░░░░"
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
echo "========================================="
