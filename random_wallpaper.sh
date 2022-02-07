#!/usr/bin/env bash

SCRIPT=$(readlink -f $0)
service_name=wallpaper.service
config_name=wallpaper.conf
config_folder=$HOME/.config/environment.d/
install_folder=$HOME/.config/systemd/user
install_target="${install_folder}/${service_name}"
config_target="${config_folder}/${config_name}"

shopt -s nullglob
# store all the image file names in wallpapers array
IFS=$'\n'
wallpapers=($(find $WALL_PATH -iregex '.*\.\(jpg\|gif\|png\|jpeg\)$'))
unset IFS

setupService() {
  mkdir -p $install_folder
	echo "Creating service file"
	cat > $install_target << EOF
[Unit]
Description=Random wallpaper

[Service]
ExecStart=${SCRIPT} daemon
StandardOutput=journal
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
}

installScript() {
	if [ -f ${install_target} ]; then
		systemctl --user stop wallpaper.service
		systemctl --user disable wallpaper.service
		rm $install_target
		rm $config_target
	else
		mkdir -p $config_folder
  	echo "WALL_PATH=${WALL_PATH}" > $config_target
		setupService
		systemctl --user enable wallpaper.service
		systemctl --user start wallpaper.service
  fi
}

setWallpaper() {
  echo "Setting wallpaper: $1"
  if [ "$DESKTOP_SESSION" == "gnome" ]; then
    gsettings set org.gnome.desktop.background picture-uri "${file}"
  fi
}

changeWallpaper() {
	if [[ -z "${WALL_PATH}" ]]; then
  	echo "Please variable export WALL_PATH=<folder path> and in ~/.config/environment.d/wallpaper.conf"
	else
  	rand=$[$RANDOM % ${#wallpapers[@]}]
		file=${wallpapers[$rand]}
  	setWallpaper $file
	fi
}

runDaemon() {
	while true
	do
  	changeWallpaper
  	sleep 15m
	done
}


echo "-----------------------------------"
echo "	       M A I N - M E N U"
echo "-----------------------------------"
echo "1: change. Change wallpaper"
echo "2: install. Install script"
echo "3: uninstall. Uninstall script"
echo "4: daemon. Run daemon"
echo "-----------------------------------"
case "$1" in
   change|1)
      changeWallpaper
   ;;
   install|2)
      installScript
   ;;
   uninstall|3)
      installScript
   ;;
   daemon|4)
      runDaemon
   ;;
   *)
      echo "Usage: $0 {change|install|uninstall|daemon}"
esac
