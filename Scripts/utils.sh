#!/bin/bash

### [ INSTALL UTILS ] ####################################################################################

while [ -n "$1" ]; do 

    COMMAND=$1
    PARAM=$2    
 
    case "$COMMAND" in
 
        system-prune | sp) 
            docker system prune -a 
            ;;

        build-prune | bp) 
            docker builder prune -a 
            ;;

        delete-logs | dl) 
            find DFL/Log -type f -delete 
            ;;
    
    #   *) 
    #       echo "OPTION [ $1 ] NOT RECOGNIZED" 
    #       ;; 
 
    esac
 
    shift
 
done