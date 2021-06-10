#!/usr/bin/env bash
sudo pacman -Syu
sudo pacman -S base-devel neofetch docker ruby nvm

sudo usermod -aG docker ${USER}
sudo systemctl enable docker.service

sudo snap install eclipse --edge --classic
sudo snap install intellij-idea-ultimate --classic
sudo snap install code --classic
sudo snap install microk8s --classic
sudo snap install insomnia

sudo usermod -aG microk8s ${USER} 

sudo -u $USER nvm install 14
sudo -u $USER npm install --global yarn

# Yarn
sudo -u $USER mkdir ~/.yarn-global
sudo -u $USER yarn config set global-folder ~/.yarn-global
sudo -u $USER yarn config set prefix ~/.yarn-global
sudo -u $USER echo 'export PATH="$PATH:$(yarn global bin)"' >> ~/.bash_profile
# Npm
sudo -u $USER mkdir ~/.npm-global
sudo -u $USER npm config set prefix '~/.npm-global'
sudo -u $USER echo 'PATH=~/.npm-global/bin:$PATH' >> ~/.bash_profile
source ~/.bash_profile

sudo -u $USER pip3 install --user neovim 

sudo -u $USER echo "export DOTNET_CLI_TELEMETRY_OPTOUT=1" >> ~/.bashrc
sudo -u $USER curl -s 'https://get.sdkman.io' | bash

