#!/bin/bash
echo "Please enter in URL for plex download"
read link


ssh [hostname] service plexmediaserver stop
echo "Downloading RPM"

ssh [hostname] wget -q -P /var/tmp/ $link
RPM=$(ssh plex ls /var/tmp/ | grep .rpm | head -1)


ssh plex rpm -Uvh /var/tmp/$RPM
echo "RPM installed: Restarting Plex on Plex"

ssh -t [hostname] service plexmediaserver start 2> /dev/null
ssh [hostname] rm /var/tmp/$RPM
ssh -t [hostname] service plexmediaserver status

echo "Update Done on Plex"
