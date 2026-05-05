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

### [ GIT UTILS ] #######################################################################################

while [ -n "$1" ]; do 

    COMMAND=$1
    PARAM=$2    
    GIT_DIR=$(ReadIni "GIT_DIR")
    GIT_NAME=$(ReadIni "GIT_NAME")
        
    case "$COMMAND" in

        init)
            echo "# $GIT_NAME" >> README.md
            git init
            git add --all
            git commit -m "$(date +'[%d/%m/%Y] | [%H:%M]') - First Commit"
            git branch -M main
            git remote add origin $GIT_DIR
            git push -u origin main
            ;;

        push)
            if [ -z "$PARAM" ]; then
                echo "To run need a Commit Message | EX : 'Simple Commit' "
            else
                git add .
                git commit -m "$(date +'[%d/%m/%Y] | [%H:%M]') - $PARAM"
                git push
            fi
            ;;
 
        dir)
            echo $GIT_DIR
            ;;   

        remove.dir)            
            rm -r .git
            ;; 

        status)            
            git status
            ;;

        commits)
            echo " "
            echo "[ COMMITS HISTORY ]" 
            echo " "
            git log --oneline
            echo " "
            ;; 

        info)  
            echo " "
            echo "[ CONTRIBUTIONS BY AUTHOR ]"      
            echo " "    
            git shortlog -sn --all
            echo " "
            echo "[ TOP FILES MODIFICATED ]"
            echo " "
            git log --pretty=format: --name-only | sort | uniq -c | sort -rg | head -10
            echo " " 
            ;;         

    #   *) 
    #       echo "OPTION [ $1 ] NOT RECOGNIZED" 
    #       ;; 
 
    esac
 
    shift
 
done