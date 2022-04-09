#!/usr/bin/env bash
echo "Sway setup"
install_packages() {
  sudo pacman -S --noconfirm sway i3status swayidle swaylock waybar otf-font-awesome alacritty bemenu bemenu-wayland mako grim udiskie pavucontrol blueman
}
