#!/bin/bash

### [ PRODUCTION UTILS ] ####################################################################################

while [ -n "$1" ]; do 

    COMMAND=$1
    PARAM=$2    
 
    case "$COMMAND" in
 
        samba.recycle)
            cd /mnt/.recycle
            echo "Disk space before empty samba recycle"
            df -h /mnt
            echo "Samba recycle content"
            ls -a
            rm -r * -I
            echo "Disk space after empty samba recycle"
            df -h /mnt
            ;; 

        rclone.clean.log)
            cat /dev/null > /mnt/CWDIR-PRODUCTION/GTGTCOM/RClone/LOG/cron.log
            ;; 
    
    #   *) 
    #       echo "OPTION [ $1 ] NOT RECOGNIZED" 
    #       ;; 
 
    esac
 
    shift
 
done