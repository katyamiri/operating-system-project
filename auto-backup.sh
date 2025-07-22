#!/bin/bash

# section 1

SRC_DIR="$1"
FILE_EXT="$2"

echo "Source directory: $SRC_DIR"
echo "File extension: $FILE_EXT"

find "$SRC_DIR" -type f -name "*.$FILE_EXT" > backup.conf

# section 2

DEST_DIR="$3"
mkdir -p "$DEST_DIR"

# section 3

TIMESTAMP=$(date +"%Y%m%d%H%M%S")
BACKUP_NAME="backup_$TIMESTAMP"

TMP_DIR="/tmp/$BACKUP_NAME"
mkdir "$TMP_DIR"

while read FILE; do
    cp --parents "$FILE" "$TMP_DIR"
done < backup.conf

tar -czf "$DEST_DIR/$BACKUP_NAME.tar.gz" -C /tmp "$BACKUP_NAME"

rm -rf "$TMP_DIR"

# section 4

LOG_FILE="backup.log"
echo "[$(date)] Backup $BACKUP_NAME created at $DEST_DIR" >> "$LOG_FILE"

# section 5

find "$DEST_DIR" -name "*.tar.gz" -mtime +7 -exec rm {} \;

# optional part

# dry-run

if [[ "$4" == "--dry-run" ]]; then 
    echo "[DRY-RUN] would copy files:"
    cat backup.conf
    echo "[DRY-RUN] would create archive: $DEST_DIR/$BACKUP_NAME.tar.gz"
    exit 0
fi


