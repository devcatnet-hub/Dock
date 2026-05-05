#!/bin/bash

CFG_FILE=.env

### [ CONFIG FILE ] #####################################################################################
# SOURCE: https://poesiabinaria.net/2018/02/leer-ficheros-configuracion-ini-desde-scripts-bash/

function ReadIni()
{
    if [ -z $2 ]; then
        awk -F "=" '/'"$1"'/ {print $2}' "$CFG_FILE"
    else
        awk -F "=" '/'"$1"'/ {print $2}' "$2"
    fi
}

### [ SERVICE UTILS ] ###################################################################################

while [ -n "$1" ]; do 

    COMMAND=$1
    SERVICE_NAME=$2    
    IMAGE_FULL_NAME=$(ReadIni "IMAGE_FULL_NAME")
    IMAGE_NAME=$(ReadIni "IMAGE_NAME")
    CONTAINER_NAME=$(ReadIni "CONTAINER_NAME")

    if [ -z "$SERVICE_NAME" ]; then
        SN="$CONTAINER_NAME"
    else
        SN="$SERVICE_NAME"
    fi
 
    case "$COMMAND" in

        new.production)
                docker-compose up -d 
                cp /mnt/Dock/Scripts/Templates/template.service /etc/systemd/system/$SN.service                
                sed -i "s/CONTAINER/$CONTAINER_NAME/g" /etc/systemd/system/$SN.service
                systemctl enable $SN.service  
                service $SN start
                service $SN status
            ;;
 
        create)         
                cp /mnt/Dock/Scripts/Templates/template.service /etc/systemd/system/$SN.service                
                sed -i "s/CONTAINER/$CONTAINER_NAME/g" /etc/systemd/system/$SN.service
            ;; 

        delete)         
                rm /etc/systemd/system/$SN.service  
            ;; 

        enable)         
                systemctl enable $SN.service  
            ;; 
        
        disable)         
                systemctl disable $SN.service  
            ;; 

        status)         
                service $SN status
            ;; 

        start)         
                service $SN start
            ;; 

        stop)         
                service $SN stop
            ;; 

        restart)         
                service $SN stop
                service $SN start
            ;; 

        unmask)         
                systemctl unmask $SN
            ;;

        reload)         
                systemctl reload $SN
            ;;

        list.all)         
                systemctl list-units -t service --all
            ;;

        list.active)         
                systemctl list-units -t service
            ;;


    #    *) 
    #        echo "OPTION [ $1 ] NOT RECOGNIZED" 
    #        ;; 
 
    esac
 
    shift
 
done