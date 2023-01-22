#!/bin/sh

# Define the file to watch
file="/config/wg0.conf"

# Continuously check if the file has been modified
sleep 10 # give the container some time to start the wireguard server
echo $(stat -c %Y $file) > /wg-lastmodified
while true; do
    # Check the last modified time of the file
    if [ $(stat -c %Y $file) != $(cat wg-lastmodified) ]; then
        # Update the lastmodified file with the current time
        echo $(stat -c %Y $file) > /wg-lastmodified

        echo "[INFO] wg0.conf changed. restarting wireguard service."
        wg-quick down wg0
        wg-quick up wg0
    fi
    # Sleep for 1 second before checking again
    sleep 1
done
