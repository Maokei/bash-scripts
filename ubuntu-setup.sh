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
sudo add-apt-repository -y ppa:enlightenment-git/ppa
sudo add-apt-repository -y ppa:graphics-drivers/ppa
sudo add-apt-repository -y ppa:numix/ppa
sudo add-apt-repository -y ppa:moka/stable

# google repository
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# spotify ppa
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# insync repository
$ wget -qO - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key \
| sudo apt-key add -

# nodesource ppa nodejs
curl -sL https://deb.nodesource.com/setup | sudo bash -

# basic update
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade


# install apps
sudo apt-get -y install \
    spotify-client sublime-text-installer git gitg \
    virtualbox virtualbox-guest-additions-iso filezilla \
    skype gimp p7zip p7zip-full p7zip-rar unity-tweak-tool \
    indicator-multiload curl gparted dkms google-chrome-stable \
    mcrypt mysql-server postgresql postgresql-contrib maven \
    linux-headers-generic insync moka-icon-theme pavucontrol \
    build-essential ubuntu-make terminology nodejs npm nodejs-legacy \
    atom telegram steam vlc synaptic gufw blender vim codeblocks htop \
    moka-gtk-theme numix-gtk-theme numix-icon-theme-circle python-pip \
	

# nvidia 
#sudo apt-get -y install nvidia-355

# Virtualbox
sudo adduser $USER vboxusers

# Terminal
#cp -a ./data/gconf/%gconf.xml ~/.gconf/apps/gnome-terminal/profiles/Default/


# clear folders
rm -rf ~/Public
rm -rf ~/Templates
rm ~/examples.desktop

#make
mkdir ~/Documents/Code
mkdir ~/Documents/Nodejs

# launcher minimize on click
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ launcher-minimize-window true

# launcher bottom
gsettings set com.canonical.Unity.Launcher launcher-position Bottom

# update system settings
gsettings set com.canonical.indicator.power show-percentage true
gsettings set com.canonical.indicator.sound interested-media-players "['spotify.desktop']"
gsettings set com.canonical.indicator.sound preferred-media-players "['spotify.desktop']"
gsettings set com.canonical.Unity.Launcher favorites "['application://google-chrome.desktop', 'application://sublime-text.desktop', 'application://spotify.desktop', 'application://nautilus.desktop', 'application://gnome-control-center.desktop', 'application://gitg.desktop', 'application://gnome-terminal.desktop', 'application://telegram.desktop', 'unity://expo-icon', 'unity://devices']"

# desktop
gsettings set org.gnome.desktop.default-applications.terminal exec 'gnome-terminal'
gsettings set org.gnome.desktop.media-handling autorun-never true
gsettings set org.gnome.desktop.privacy remember-recent-files false

# gitg preferences
gsettings set org.gnome.gitg.preferences.commit.message right-margin-at 72
gsettings set org.gnome.gitg.preferences.commit.message show-right-margin true
gsettings set org.gnome.gitg.preferences.diff external false
gsettings set org.gnome.gitg.preferences.hidden sign-tag true
gsettings set org.gnome.gitg.preferences.view.files blame-mode true
gsettings set org.gnome.gitg.preferences.view.history collapse-inactive-lanes 2
gsettings set org.gnome.gitg.preferences.view.history collapse-inactive-lanes-active true
gsettings set org.gnome.gitg.preferences.view.history search-filter false
gsettings set org.gnome.gitg.preferences.view.history show-virtual-staged true
gsettings set org.gnome.gitg.preferences.view.history show-virtual-stash true
gsettings set org.gnome.gitg.preferences.view.history show-virtual-unstaged true
gsettings set org.gnome.gitg.preferences.view.history topo-order false

# power
#gsettings set org.gnome.settings-daemon.plugins.power critical-battery-action 'shutdown'
#gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
#gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'nothing'

# nautilus 
gsettings set org.gnome.nautilus.list-view default-zoom-level 'smaller'
gsettings set org.gnome.nautilus.preferences executable-text-activation 'ask'

# update some more system settings
dconf write /org/compiz/profiles/unity/plugins/unityshell/icon-size 32
dconf write /org/compiz/profiles/unity/plugins/core/vsize 1
dconf write /org/compiz/profiles/unity/plugins/core/hsize 5
dconf write /org/compiz/profiles/unity/plugins/opengl/texture-filter 2
#dconf write /org/compiz/profiles/unity/plugins/unityshell/alt-tab-bias-viewport false


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
