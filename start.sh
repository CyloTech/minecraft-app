#!/bin/bash
set -x

if [ ! -f /etc/mc_installed ]; then
    mkdir /home/minecraft
    mv /home/mcmyadmin/* /home/minecraft/

    cd /home/minecraft
    ./MCMA2_Linux_x86_64 -nonotice -updateonly

    touch /etc/mc_installed
    curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST "https://api.cylo.io/v1/apps/installed/$INSTANCE_ID"

    # This is the first run, so set the admin PW and start it up for the first time.
    ./MCMA2_Linux_x86_64 -setpass "$ADMIN_PASS" +java.memory $JAVA_MEMORY &
    sleep 10;

    while ! nc -z localhost 80; do
      echo "Sleeping for 1 second whilst we wait for it to come online"
      sleep 1
    done

    pkill -9 MCMA2

    echo "***************************************************************************"
fi

cd /home/minecraft
./MCMA2_Linux_x86_64 +java.memory $JAVA_MEMORY