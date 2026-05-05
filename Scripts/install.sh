#!/bin/bash

### [ INSTALL UTILS ] ####################################################################################

while [ -n "$1" ]; do 

    COMMAND=$1
    PARAM=$2    
 
    case "$COMMAND" in
 
        info.path)
            echo $PATH
            ;; 

        set.path)
            echo "export PATH=$PATH:/mnt/Dock" >>  ~/.bashrc
            ;; 

        set.pemkey)
            chmod 600 /mnt/Dock/Scripts/Keys/docker.pem
            chmod 600 /mnt/Dock/Scripts/Keys/docker.pem.pub
            ;; 

        set.gitkey)
            chmod 600 /mnt/Dock/Scripts/Keys/gitkey_rsa
            chmod 644 /mnt/Dock/Scripts/Keys/gitkey_rsa.pub
            ;; 

        add.gitkey)
            eval `ssh-agent`
            echo $SSH_AUTH_SOCK
            ssh-add /mnt/Dock/Scripts/Keys/gitkey_rsa
            ssh-add -l
            ssh -T git@bitbucket.org
            ;; 
    
    #   *) 
    #       echo "OPTION [ $1 ] NOT RECOGNIZED" 
    #       ;; 
 
    esac
 
    shift
 
done