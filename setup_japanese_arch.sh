#!/usr/bin/env bash
echo "Installing packages for Japanese input"

install_fcitx() {
  echo "installing fcitx"
  echo "GTK_IM_MODULE=fcitx" >> ~/.profile
  echo "QT_IM_MODULE=fcitx" >> ~/.profile
  echo "XMODIFIERS=@im=fcitx" >> ~/.profile
  sudo pacman -S --noconfirm fcitx5 fcitx5-configtool \
  fcitx5-gtk fcitx5-mozc fcitx5-qt
}

install_ibus() {
  echo "installing ibus"
  #sudo pacman -S ibus ibus-anthy
}

install_fonts() {
  echo "installing fonts"
  sudo pacman -S --noconfirm otf-ipafont adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts ttf-hanazono
}

install_fcitx
install_fonts
