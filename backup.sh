#!/bin/bash

MSG_prompt="What have you achieved?"
MSG_creatingbackup="Creating backup."
MSG_nosave="Cannot find save file."
MSG_createfolder="Creating backup folder."
MSG_backupexsits="Backup already exists."
MSG_success="Backup successful."

BACKUPS=./ds3_backups
LOADED_SAVE=~/.steam/steam/steamapps/compatdata/374320/pfx/drive_c/users/steamuser/AppData/Roaming/DarkSoulsIII

if [ ! -d "$LOADED_SAVE" ];
then
    echo $MSG_nosave
    exit -1
fi

if [ ! -d "$BACKUPS" ];
then
    echo $MSG_createfolder
    mkdir $BACKUPS
fi

echo $MSG_prompt
read comment
comment=$(echo $comment | sed 's/[^a-zA-Z0-9]//g')
comment="$(date +"%y%m%d_%H%M%S")_$comment"

if [ -d "$BACKUPS/$comment" ];
then
    echo $MSG_backupexsits
    exit -1
fi

echo $MSG_creatingbackup
mkdir "$BACKUPS/$comment"
cp -r $LOADED_SAVE $BACKUPS/$comment
echo $MSG_success
