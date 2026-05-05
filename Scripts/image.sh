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

### [ READ KEY ] ########################################################################################

function ReadKey()
{
    local PARAM=$1 
    local IMAGE_FULL_NAME=$(ReadIni "IMAGE_FULL_NAME")
    KEY=$(docker image inspect -f "{{.$PARAM}}" $IMAGE_FULL_NAME)
    export KEY=$KEY
} 

### [ IMAGES UTILS ] ####################################################################################

while [ -n "$1" ]; do 

    COMMAND=$1
    PARAM=$2    
    IMAGE_FULL_NAME=$(ReadIni "IMAGE_FULL_NAME")
    IMAGE_NAME=$(ReadIni "IMAGE_NAME")
 
    case "$COMMAND" in
 
        info)
            INFO=$(docker image inspect -f "{{.$PARAM}}" $IMAGE_FULL_NAME)
            echo $INFO
            ;;   

        delete)
            docker image rm $IMAGE_FULL_NAME
            ;;    

        push)
            docker push "$IMAGE_FULL_NAME:latest"
            ;;

        make)      
            docker build -f ./DFL/Dockerfile -t deathwalker66/$IMAGE_NAME . --no-cache 
            ;;    

        make-log)      
            mkdir -p ./DFL/Log
            docker build -f ./DFL/Dockerfile -t deathwalker66/$IMAGE_NAME . --no-cache --progress=plain 2>&1 | tee "./DFL/Log/$(date +'%Y.%m.%d - %H.%M - Log').txt"
            ;;  

        update.production)      
            dock -service stop
            dock -service disable
            dock -stop -del
            docker image rm $IMAGE_FULL_NAME
            dock -start
            dock -service enable
            dock -service start
            dock -service status
            ;;

        update.dev)
            dock -stop -del
            docker image rm $IMAGE_FULL_NAME
            dock -start
            ;;
    
    #    *) 
    #        echo "OPTION [ $1 ] NOT RECOGNIZED" 
    #        ;; 
 
    esac
 
    shift
 
done