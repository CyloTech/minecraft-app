#!/bin/bash
set -x

if [ ! -f /etc/mc_installed ]; then
    mkdir /home/minecraft
    mv /home/mcmyadmin/* /home/minecraft/

    /bin/sh /home/minecraft/MCMA2_Linux_x86_64 -nonotice -updateonly

    touch /etc/mc_installed
    curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST "https://api.cylo.io/v1/apps/installed/$INSTANCE_ID"
fi


/home/minecraft/MCMA2_Linux_x86_64 -setpass "$ADMIN_PASS" +java.memory $JAVA_MEMORY