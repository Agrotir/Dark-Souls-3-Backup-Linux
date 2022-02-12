#!/bin/bash

MSG_nosave="Cannot find save file."
MSG_nobackup="Cannot find the backup folder."
MSG_restore="Pick a backup number to restore."
MSG_confirm="Restoring this backup will override any progress you have made. Are you sure?"
MSG_abort="Restore aborted."
MSG_restoring="Restoring"
MSG_success="Restore success. Have fun."

BACKUPS=./ds3_backups
LOADED_SAVE=~/.steam/steam/steamapps/compatdata/374320/pfx/drive_c/users/steamuser/AppData/Roaming/DarkSoulsIII

if [ ! -d "$LOADED_SAVE" ];
then
    echo $MSG_nosave
    exit -1
fi

if [ ! -d "$BACKUPS" ];
then
    echo $MSG_nobackup
    exit -1
fi

while
    count=0
    for entry in "$BACKUPS"/*
    do
        count=$((count+1))
        echo "$count -- ${entry##*/}"
    done
    echo "$MSG_restore [1 ~ $count]:"
    read restorenum
    echo
    [[ -z $restorenum || $restorenum == *[^0-9]* || $restorenum -lt 1 || $restorenum -gt count ]]
do true; done

echo "$MSG_confirm [Y/N]:"
read yesno
if [ "$yesno" == y ]; then
    count=0
        for entry in "$BACKUPS"/*
        do
            count=$((count+1))
            if [ $count -eq $restorenum ]; then
                echo $MSG_restoring
                rm -r $LOADED_SAVE
                cp -r $entry/DarkSoulsIII $LOADED_SAVE
                echo $MSG_success
                break
            fi
        done
else
    echo $MSG_abort
fi

