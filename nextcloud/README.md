# Nextcloud

Docker compose setup

`docker-compose up -d`

## Cron

First we need to identify the Nextcloud container name.
Next, we are gonna try the command manually and check if it's triggered in the container. In the host terminal type:
```
docker ps
docker exec -u www-data nextcloud php cron.php
```
If the background jobs tab now show a green dot after a page refresh, the command is working, we just need to make it run every 5 Minutes.

On host add cron job: `crontab -e`
Add the following line at the end to execute it every five minutes:
`*/5 * * * * docker exec -u www-data nextcloud php cron.php`

## ARMV7
[libseccomp](http://ftp.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.3-2_armhf.deb)
