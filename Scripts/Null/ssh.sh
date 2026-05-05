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

### [ SSH UTILS ] ###################################################################################

while [ -n "$1" ]; do 

    COMMAND=$1
    PARAM01=$2    
    PARAM02=$3  
    PARAM03=$4

 
    case "$COMMAND" in
 
        nopem)  

            case "$PARAM01" in 
                local|l)

                        SSH_PORT=$(ReadIni "SSH_PORT")
                        ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[localhost]:$SSH_PORT" 
                        clear
                        ssh -o StrictHostKeyChecking=no root@localhost -p $SSH_PORT 
                ;;

                remote|r)

                        SSH_PORT=$(ReadIni "SSH_PORT")
                        ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[$PARAM03]:$PARAM02" 
                        clear                        
                        ssh -o StrictHostKeyChecking=no root@$PARAM03 -p $PARAM02 
                ;;

                external|e)

                        SSH_PORT=$(ReadIni "SSH_PORT")
                        ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[$PARAM03]:$PARAM02" 
                        clear
                        ssh -o StrictHostKeyChecking=no root@$PARAM03 -p $PARAM02 
                ;;

                host|h)

                        FILE=/mnt/Dock/Scripts/Profiles/$PARAM02
                        LOCALADDRESS=$(ReadIni "LOCALADDRESS" $FILE)
                        PORT=$(ReadIni "PORT" $FILE)

                        ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[$LOCALADDRESS]:$PORT" 
                        clear
                        ssh -o StrictHostKeyChecking=no root@$LOCALADDRESS -p $PORT 
                ;;
           
            esac
        ;; 

        pem|p)  

            case "$PARAM01" in 
                remote|r)

                        SSH_PORT=$(ReadIni "SSH_PORT")
                        ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[$PARAM03]:$PARAM02" 
                        clear
                        ssh -o StrictHostKeyChecking=no -i $HOME/.ssh/alpine.pem root@$PARAM03 -p $PARAM02 
                ;;

                external|e)

                        SSH_PORT=$(ReadIni "SSH_PORT")
                        ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[$PARAM03]:$PARAM02" 
                        clear
                        ssh -o StrictHostKeyChecking=no -i $HOME/.ssh/alpine.pem root@$PARAM03 -p $PARAM02 
                ;;

                host|h)

                        FILE=/mnt/Dock/Scripts/Profiles/$PARAM02
                        LOCALADDRESS=$(ReadIni "LOCALADDRESS" $FILE)
                        PORT=$(ReadIni "PORT" $FILE)

                        ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[$LOCALADDRESS]:$PORT" 
                        clear
                        ssh -o StrictHostKeyChecking=no -i $HOME/.ssh/alpine.pem root@$LOCALADDRESS -p $PORT 
                ;;

                remotehost|rh)

                        FILE=/mnt/Dock/Scripts/Profiles/$PARAM02
                        PUBLICADDRESS=$(ReadIni "PUBLICADDRESS" $FILE)
                        PORTREMOTE=$(ReadIni "PORTREMOTE" $FILE)

                        ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[$PUBLICADDRESS]:$PORTREMOTE" 
                        clear
                        ssh -o StrictHostKeyChecking=no -i $HOME/.ssh/alpine.pem root@$PUBLICADDRESS -p $PORTREMOTE 
                ;;

            esac
        ;;

        host)

            if [ $PARAM01 != "all" ]; then
                FILE=/mnt/Dock/Scripts/Profiles/$PARAM01
                NAME=$(ReadIni "NAME" $FILE)
                MAC=$(ReadIni "MAC" $FILE)
                PUBLICADDRESS=$(ReadIni "PUBLICADDRESS" $FILE)
                LOCALADDRESS=$(ReadIni "LOCALADDRESS" $FILE)
                LOGMEINID=$(ReadIni "LOGMEINID" $FILE)
                PORT=$(ReadIni "PORT" $FILE)
                echo
                echo "Host Name:        $NAME"
                echo "MAC Address:      $MAC"
                echo "Public Address:   $PUBLICADDRESS"
                echo "Local Address:    $LOCALADDRESS"
                echo "LogMeIn ID:       $LOGMEINID"
                echo "SSh Port:         $PORT"
                echo
            else
                mapfile -d $'\0' array < <(find /mnt/Dock/Scripts/Profiles -print0)
                len=${#array[*]}
                i=1

                while [ $i -lt $len ]
                do

                FILE=${array[$i]}
                NAME=$(ReadIni "NAME" $FILE)
                MAC=$(ReadIni "MAC" $FILE)
                PUBLICADDRESS=$(ReadIni "PUBLICADDRESS" $FILE)
                LOCALADDRESS=$(ReadIni "LOCALADDRESS" $FILE)
                LOGMEINID=$(ReadIni "LOGMEINID" $FILE)
                PORT=$(ReadIni "PORT" $FILE)
                echo
                echo "Host Name:        $NAME"
                echo "MAC Address:      $MAC"
                echo "Public Address:   $PUBLICADDRESS"
                echo "Local Address:    $LOCALADDRESS"
                echo "LogMeIn ID:       $LOGMEINID"
                echo "SSh Port:         $PORT"
                echo

                let i++
                done
            fi           

        ;;

        array)

            mapfile -d $'\0' array < <(find /mnt/Dock -name .env -print0)

            len=${#array[*]}
            echo "found : ${len}"

            i=0

            while [ $i -lt $len ]
            do

            echo $(ReadIni "CONTAINER_NAME" "${array[$i]}") = $(ReadIni "SSH_PORT" "${array[$i]}")

            let i++
            done

        ;;            

    #    *) 
    #        echo "OPTION [ $1 ] NOT RECOGNIZED" 
    #        ;; 
 
    esac
 
    shift
 
done