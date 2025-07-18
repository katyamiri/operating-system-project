#!/bin/bash

SRC_DIR="$1"
FILE_EXT="$2"

echo "Source directory: $SRC_DIR"
echo "File extension: $FILE_EXT"

find "$SRC_DIR" -type f -name "*$FILE_EXT" > backup.conf

DEST_DIR="$3"
mkdir -p "$DEST_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_$TIMESTAMP"

TMP_DIR="/tmp/%BACKUP_NAME"
mkdir "$TMP_DIR"

while read FILE; do
    cp --parents "$FILE" "$TMP_DIR"
done < backup.conf
