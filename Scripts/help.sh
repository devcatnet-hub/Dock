#!/bin/bash

HLP_FILE=help

### [ HELP FILE ] #######################################################################################
# SOURCE: https://poesiabinaria.net/2018/02/leer-ficheros-configuracion-ini-desde-scripts-bash/

function ReadHelp()
{
    local KEY="$1_$2"
    awk -F "=" '/'"$KEY"'/ {print $2}' "/mnt/Dock/Scripts/$HLP_FILE"
}

### [ HELP UTILS ] ######################################################################################

COMMAND="$1"
PARAM="$2"
HELP=$(ReadHelp "$COMMAND" "$PARAM") 
echo -e $HELP

cat /mnt/Dock/Scripts/Help/$COMMAND.$PARAM
echo -e 
