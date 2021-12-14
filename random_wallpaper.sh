#!/bin/bash

# start my custom script for setting random background wallpapers
#if [ -f "$HOME/.random_wallpapers.sh" ] ; then
#    bash $HOME/.random_wallpapers.sh &
#fi

export wallpaper_path="/home/$USER/Pictures"
shopt -s nullglob
# store all the image file names in wallpapers array
wallpapers=(
    $wallpaper_path/*.jpg
    $wallpaper_path/*.jpeg
    $wallpaper_path/*.png
    $wallpaper_path/*.bmp
    $wallpaper_path/*.svg
)
# get array size
# wallpapers_size=${#wallpapers[*]}

# random from array
while true
do
    rand=$[$RANDOM % ${#wallpapers[@]}]
    file=${wallpapers[$rand]}
    FILE_PATH=$( echo "$file" | sed 's/ /\\ /g' )
    gsettings set org.gnome.desktop.background picture-uri ${FILE_PATH}
    sleep 15m
done
