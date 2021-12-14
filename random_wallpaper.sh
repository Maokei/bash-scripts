#!/bin/bash

# start my custom script for setting random background wallpapers
#if [ -f "$HOME/.random_wallpapers.sh" ] ; then
#    bash $HOME/.random_wallpapers.sh &
#fi

export wallpaper_path="/home/$USER/Pictures"
shopt -s nullglob
# store all the image file names in wallpapers array
IFS=$'\n'
wallpapers=($(find $wallpaper_path -iregex '.*\.\(jpg\|gif\|png\|jpeg\)$'))
unset IFS

# random from array
while true
do
    rand=$[$RANDOM % ${#wallpapers[@]}]
    file=${wallpapers[$rand]}
    gsettings set org.gnome.desktop.background picture-uri "${file}"
    sleep 15m
done
