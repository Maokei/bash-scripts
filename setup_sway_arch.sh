#!/usr/bin/env bash
echo "Sway setup"
install_packages() {
  sudo pacman -S --no-confirm sway i3status swayidle swaylock alacritty
}
