#!/usr/bin/env bash
# Ubuntu 18.10 install script
#

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
sudo add-apt-repository -y ppa:atareao/telegram
sudo add-apt-repository -y ppa:remmina-ppa-team/remmina-next
sudo add-apt-repository -y ppa:peek-developers/daily

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

#Nodejs
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update

#Docker no official release yet for 18.10
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

#install snaps
sudo snap install intellij-idea-community --classic
#sudo snap install eclipse --edge --classic
sudo snap install sublime-text --classic
sudo snap install slack --classic
sudo snap install notepad-plus-plus --classic
sudo snap install kotlin --classic
sudo snap install robo3t-snap
sudo snap install postman
sudo snap install insomnia
sudo snap install ubuntu-make --classic

#update
sudo apt update

#install
sudo apt install -y git neofetch docker-ce virtualbox virtualbox-ext-pack \
virtualbox-guest-additions-iso virtualbox-guest-dkms linux-headers-virtual \
remmina remmina-plugin-rdp libfreerdp-plugins-standard mongodb peek asciio \
mysql-server mysql-workbench postgresql postgresql-contrib tmux vlc zeal \
htop tree ranger neovim p7zip p7zip-full p7zip-rar code powerline meld guake \
ubuntu-restricted-extras gcc g++ make nodejs yarn python3-pip wireshark tlp

#groups
sudo usermod -aG docker ${USER}
sudo usermod -aG vboxusers ${USER}

echo "if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then" >> ~/.bashrc
echo "    source /usr/share/powerline/bindings/bash/powerline.sh" >> ~/.bashrc
echo "fi" >> ~/.bashrc

su -c "mkdir ~/.npm-global" $USER
su -c "npm config set prefix '~/.npm-global'" $USER
echo 'PATH=~/.npm-global/bin:$PATH' >> ~/.profile
source ~/.profile

#sdkman
#curl -s 'https://get.sdkman.io' | bash
#wget -c https://flavio.tordini.org/files/minitube/minitube.deb

#inode watch
sudo echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf

sudo systemctl enable tlp
sudo systemctl enable mongodb

#Vs code extensions
su - "$USER" -c "code --install-extension ms-python.anaconda-extension-pack
code --install-extension vscjava.vscode-java-pack
code --install-extension PeterJausovec.vscode-docker
code --install-extension johnpapa.angular-essentials
code --install-extension robinbentley.sass-indented
code --install-extension ms-vscode.cpptools
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension HookyQR.beautify
code --install-extension ritwickdey.LiveServer
code --install-extension jawandarajbir.react-vscode-extension-pack"

#bash alias
touch ~/.bash_aliases
echo "neofetch" >> ~/.bash_aliases

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
