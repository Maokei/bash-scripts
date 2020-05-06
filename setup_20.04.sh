#!/usr/bin/env bash
# Ubuntu 20.04 install script

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
done

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:remmina-ppa-team/remmina-next
sudo add-apt-repository -y ppa:peek-developers/daily
sudo add-apt-repository -y ppa:thomas-schiex/blender

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#Nodejs
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update

#Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu eoan stable"

#Brave brower
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list


#install snaps
sudo snap install intellij-idea-community --classic
sudo snap install eclipse --edge --classic
sudo snap install slack --classic
sudo snap install notepad-plus-plus --classic
sudo snap install kotlin --classic
sudo snap install robo3t-snap
sudo snap install postman
sudo snap install insomnia
sudo snap install ubuntu-make --classic
sudo snap install code --classic
sudo snap install ripgrep --classic
sudo snap install cool-retro-term --edge --classic
sudo snap install figma-linux

#update
sudo apt update

#install
sudo apt install -y git neofetch virtualbox virtualbox-ext-pack \
virtualbox-guest-additions-iso virtualbox-guest-dkms linux-headers-virtual \
remmina remmina-plugin-rdp synaptic mongodb peek asciio feh \
mysql-server default-jre postgresql postgresql-contrib tmux vlc zeal \
htop tree ranger neovim p7zip p7zip-full p7zip-rar powerline fonts-powerline meld guake \
ubuntu-restricted-extras gcc g++ make nodejs yarn python3-pip wireshark tlp \
docker-ce docker-ce-cli containerd.io brave-browser

#groups
sudo usermod -aG docker ${USER}
sudo usermod -aG vboxusers ${USER}

sudo -u $USER echo "if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then" >> ~/.bashrc
sudo -u $USER echo "    source /usr/share/powerline/bindings/bash/powerline.sh" >> ~/.bashrc
sudo -u $USER echo "fi" >> ~/.bashrc

sudo -u $USER mkdir ~/.yarn-global
sudo -u $USER yarn config set globa-dir ~/.yarn-global

sudo -u $USER mkdir ~/.npm-global
sudo -u $USER npm config set prefix '~/.npm-global'
sudo -u $USER echo 'PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile

sudo -u $USER wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
wget -c https://flavio.tordini.org/files/minitube/minitube.deb \
wget -c https://zoom.us/client/latest/zoom_amd64.deb

sudo dpkg -i ./google-chrome*.deb
sudo dpkg -i ./minitube.deb
sudo dpkg -i ./zoom_amd64.deb
rm *.deb
sudo apt install -f -y

#inode watch
sudo echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf

sudo systemctl enable tlp
sudo systemctl enable mongodb

#Vs code extensions
sudo -u $USER code --install-extension ms-python.anaconda-extension-pack \
code --install-extension vscjava.vscode-java-pack \
code --install-extension PeterJausovec.vscode-docker \
code --install-extension johnpapa.angular-essentials \
code --install-extension robinbentley.sass-indented \
code --install-extension ms-vscode.cpptools \
code --install-extension msjsdiag.debugger-for-chrome \
code --install-extension HookyQR.beautify \
code --install-extension ritwickdey.LiveServer \
code --install-extension jawandarajbir.react-vscode-extension-pack \
code --install-extension xabikos.JavaScriptSnippets \
code --install-extension usernamehw.indent-one-space \
code --install-extension vscjava.vscode-java-pack \
code --install-extension Pivotal.vscode-spring-boot \
code --install-extension vscjava.vscode-spring-initializr \
code --install-extension vscjava.vscode-spring-boot-dashboard \
code --install-extension GabrielBB.vscode-lombok

sudo -u $USER pip3 install --user neovim \
sudo -u $USER curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#Joplin
sudo -u $USER echo "wget -O - https://raw.githubusercontent.com/laurent22/joplin/master/Joplin_install_and_update.sh | bash" 

#bash alias
sudo -u $USER touch ~/.bash_aliases
sudo -u $USER echo "alias untar='tar -zxvf '" >> ~/.bash_aliases
sudo -u $USER echo "alias www='python -m SimpleHTTPServer 8000'" >> ~/.bash_aliases
sudo -u $USER echo "alias showGoverners='cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors'" >> ~/.bash_aliases
sudo -u $USER echo "alias lowPerf='echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'" >> ~/.bash_aliases
sudo -u $USER echo "alias highPerf='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'" >> ~/.bash_aliases
sudo -u $USER echo "alias kdeRe='kquitapp5 plasmashell && kstart5 plasmashell'" >> ~/.bash_aliases
sudo -u $USER echo 'neofetch' >> ~/.bash_aliases

#desktop specific
if [ -n "$GNOME" ]; then
	echo "Desktop: Gnome"
	sudo -u $USER gsettings set org.gnome.desktop.interface enable-animations false
	sudo -u $USER gsettings set org.gnome.desktop.background show-desktop-icons false
	# tracker-miner-fs
	sudo -u $USER gsettings set org.freedesktop.Tracker.Miner.Files crawling-interval -2  
	sudo -u $USER gsettings set org.freedesktop.Tracker.Miner.Files enable-monitors false
	sudo -u $USER tracker reset --hard
	sudo apt install -y gnome-tweak-tool chrome-gnome-shell
fi


#sdkman
sudo -u $USER curl -s 'https://get.sdkman.io' | bash

#secure mysql
sudo mysql_secure_installation

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
