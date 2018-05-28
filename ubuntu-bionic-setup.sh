#!/bin/bash

# add repos
sudo add-apt-repository -y ppa:dimula73/krita
sudo add-apt-repository -y ppa:inkscape.dev/stable
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
sudo add-apt-repository -y ppa:stefansundin/truecrypt
sudo add-apt-repository -y ppa:ubuntu-desktop/ubuntu-make
sudo add-apt-repository -y ppa:damien-moore/codeblocks
sudo add-apt-repository -y ppa:webupd8team/atom
sudo add-apt-repository -y ppa:thomas-schiex/blender
sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:moka/stable
sudo add-apt-repository -y ppa:zeal-developers/ppa
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:dawidd0811/neofetch

# nodejs
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# docker
sudo apt -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable edge"


# nodesource ppa nodejs
curl -sL https://deb.nodesource.com/setup | sudo bash -

# basic update
sudo apt -y --force-yes update
sudo apt -y --force-yes upgrade

# install apps
sudo apt -y install \
    sublime-text-installer git gitg truecrypt \
    virtualbox virtualbox-guest-additions-iso filezilla \
    gimp p7zip p7zip-full p7zip-rar neofetch \
    indicator-multiload curl gparted dkms \
    mcrypt mysql-server postgresql postgresql-contrib maven \
    linux-headers-generic moka-icon-theme pavucontrol \
    build-essential ubuntu-make zeal nodejs yarn tmux \
    atom telegram vlc synaptic gufw blender vim codeblocks htop \
    moka-gtk-theme numix-gtk-theme numix-icon-theme-circle python-pip \

# java
sudo apt -y install oracle-java8-installer
echo 'export JAVA_HOME="/usr/lib/jvm/java-8-oracle"' >> ~/.bashrc

# install docker
sudo apt -y install docker-ce
sudo groupadd docker
sudo gpasswd -a $USER docker

# install snap apps
sudo snap install slack
sudo snap install notepad-plus-plus
sudo snap install spotify
sudo snap install vscode

# powerline https://gist.github.com/leosuncin/25bad6ae66c5d513b986
sudo pip install powerline-status
git clone https://github.com/powerline/fonts.git && cd fonts && sh ./install.sh

echo 'if [ -f /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
source /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi' >> ~/.bashrc

# neofetch
echo 'neofetch' >> ~/.bashrc

# Virtualbox
sudo adduser $USER vboxusers

# clear folders
rm -rf ~/Public
rm -rf ~/Templates
rm ~/examples.desktop

#make
mkdir ~/Documents/Code
mkdir ~/Documents/Nodejs

# desktop
gsettings set org.gnome.desktop.default-applications.terminal exec 'gnome-terminal'
gsettings set org.gnome.desktop.media-handling autorun-never true
gsettings set org.gnome.desktop.privacy remember-recent-files false

# requires clicks
sudo apt-get install -y ubuntu-restricted-extras


#reboot
clear
echo ""
echo "========================================="
echo "░░░░░░░░▄▄▄▀▀▀▄▄███▄░░░░░░░░░░░░░░░░░" 
echo "░░░░░░▄▀▀░░░░░░░▐░▀██▌░░░░░░░░░░░░░░░░" 
echo "░░░░▄▀░░░░▄▄███░▌▀▀░▀█░░░░░░░░░░░░░░░" 
echo "░░▄█░░▄▀▀▒▒▒▒▒▄▐░░░░█▌░░░░░░░░░░░░░░░░"
echo "░▐█▀▄▀▄▄▄▄▀▀▀▀▌░░░░░▐█▄░░░░░░░░░░░░" 
echo "░▌▄▄▀▀░░░░░░░░▌░░░░▄███████▄░░░░░░░░░░" 
echo "░░░░░░░░░░░░░▐░░░░▐███████████▄░░░░░░░░░" 
echo "░░░░░le░░░░░░░▐░░░░▐█████████████▄░░░░░░" 
echo "░reboot toucan░▀▄░░░▐██████████████▄ ░░░"
echo "░░░░░░has░░░░░░░░▀▄▄████████████████▄░░░"
echo "░░░░░arrived░░░░░░░░░░░░█▀██████░░░░░░░░░"
echo "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
echo "=========================================="
