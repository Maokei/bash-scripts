#!/bin/bash

: '
Assuming executable script
/usr/lib/systemd/user/wallpaper.service

[Unit]
Description=Random wallpaper

[Service]
ExecStart=/usr/bin/random_wallpaper.sh
Type=oneshot
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
'

export wallpapers_path="/home/$USER/Pictures"
shopt -s nullglob
# store all the image file names in wallpapers array
IFS=$'\n'
wallpapers=($(find $wallpapers_path -iregex '.*\.\(jpg\|gif\|png\|jpeg\)$'))
unset IFS

setWallpaper() {
    echo "Setting wallpaper: $1"
    if [ "$DESKTOP_SESSION" == "gnome" ]; then   
        gsettings set org.gnome.desktop.background picture-uri "${file}"
    fi
}

# random from array
while true
do
    rand=$[$RANDOM % ${#wallpapers[@]}]
    file=${wallpapers[$rand]}
    setWallpaper $file
    sleep 15m
done
