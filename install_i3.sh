#!/usr/bin/env bash
#ubuntu 19.04 i3-gaps, light
echo "Trying to remove i3"

sudo apt remove --purge i3*

echo "Installing i3-gaps"

echo "Install dependencies"
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
libstartup-notification0-dev libxcb-randr0-dev \
libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev


sudo apt install -y cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev \
libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev \
libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev libasound2-dev \
libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev libxcb-composite0-dev



echo "Clone repo"
cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

echo "Compile and install"
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

#install i3 extras
sudo apt install -y i3lock-fancy i3status nitrogen

#build light
cd /tmp
git clone https://github.com/haikarainen/light.git
cd light
./autogen.sh
./configure && make
sudo make install

#build polybar
cd /tmp
git clone https://github.com/jaagr/polybar.git
cd polybar && ./build.sh

#bluetooth
sudo apt install -y blueman

echo "Reboot for good measure"
sudo reboot
