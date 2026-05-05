#!/bin/bash

CFG_FILE=.env
UNAME=$(uname -v)

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

### [ START CONTAINER ] #################################################################################

function startContainer()
{
    local CONTAINER="$1"
    local RUN=$(docker inspect -f "'{{.State.Running}}'" $CONTAINER)
    if [ $RUN != "'true'" ]; then
            docker-compose up -d
    fi
}

### [ NAME CONTAINER ] ##################################################################################

function containerID()
{
    local CONTAINER="$1"
    local NAME=$(docker inspect -f   '{{.Id}}' $CONTAINER)
    export CONTAINERID=$NAME
}

### [ CONTAINER INTERNARS COMMANDS ] ####################################################################

while [ -n "$1" ]; do 

    COMMAND=$1
    PARAM=$2    
    CONTAINER_NAME=$(ReadIni "CONTAINER_NAME")
 
    case "$COMMAND" in
 
        passwd)
            startContainer $CONTAINER_NAME 
            docker container exec -it $CONTAINER_NAME passwd
            ;;

        run)
            startContainer $CONTAINER_NAME 
            docker container exec -it $CONTAINER_NAME $PARAM
            ;;   

        cmd)
            startContainer $CONTAINER_NAME 
            docker container exec -it $CONTAINER_NAME "/COM/command.com" $PARAM 
            ;;  
        
        upgrade)
            UPGRADE="apk --no-cache upgrade"
            startContainer $CONTAINER_NAME 
            docker container exec -it $CONTAINER_NAME $UPGRADE
            ;;

        add)
            ADD="apk --no-cache add $PARAM"
            startContainer $CONTAINER_NAME 
            docker container exec -it $CONTAINER_NAME $ADD
            ;;

        del)
            DEL="apk del $PARAM"
            startContainer $CONTAINER_NAME 
            docker container exec -it $CONTAINER_NAME $DEL
            ;;

        bash)
            docker container exec -it $CONTAINER_NAME /bin/bash 
            ;;

        get)
            FILENAME="$2"
            containerID $CONTAINER_NAME
            fileName=$(basename "$FILENAME")
            if [ -d "./TMP" ]; then
                docker cp $CONTAINERID:$FILENAME ./TMP/$fileName
            else
                mkdir TMP
                docker cp $CONTAINERID:$FILENAME ./TMP/$fileName
            fi
            ;;   
                          
        post)
                    echo "[WISH LIST]"
                    ;;

    #    *) 
    #        echo "OPTION [ $1 ] NOT RECOGNIZED" 
    #        ;; 
 
    esac
 
    shift
 
done