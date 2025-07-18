#!/bin/bash

SRC_DIR="$1"
FILE_EXT="$2"

echo "Source directory: $SRC_DIR"
echo "File extension: $FILE_EXT"

DEST_DIR="$3"
mkdir -p "$DEST_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_$TIMESTAMP"
