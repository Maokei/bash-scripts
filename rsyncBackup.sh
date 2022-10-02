#!/bin/bash
# usage: ./rsyncDontStop.sh -s ~/Documents -d pathToTarget
# Keeps trying until rsync exists normally
while getopts s:d: flag
do
    case "${flag}" in
        s) source=${OPTARG};;
        d) destination=${OPTARG};;
    esac
done
echo "Source, backing up too: $source"
echo "Destination, backing up from: $destination"


# Purge all node_modules folders
#find $source  -name "node_modules" -type d -prune -exec rm -rf '{}' +
#rsync -auvhp --delete --exclude=node_modules [source] [destination]
rsync -auvhp --delete --exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/cdrom/*,/lost+found,/node_modules/*}  $source $destination
