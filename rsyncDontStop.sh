#!/bin/bash
# usage: ./rsyncDontStop.sh -u username -s some.domain.com -f filename.extension -d pathToFolder
# Keeps trying until rsync exists normally
while getopts f:s:u:d: flag
do
    case "${flag}" in
        f) file=${OPTARG};;
        s) url=${OPTARG};;
        d) destination=${OPTARG};;
        u) username=${OPTARG};;
    esac
done
echo "username: $username";
echo "Url: $url"
echo "File: $file";
echo "Destination: $destination";
while [ 1 ]
do
    rsync -v --partial --progress --rsh=ssh $file $username@$url:$destination
    if [ "$?" = "0" ] ; then
        echo "rsync completed normally"
        exit
    else
        echo "Rsync failure. Backing off and retrying..."
        sleep 180
    fi
done
