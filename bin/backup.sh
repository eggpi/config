#!/bin/bash

# Adapted from http://www.sanitarium.net/golug/rsync_backups_2010.html

set -u # fail when expanding empty variables

# User and server to which we'll copy the files,
# leave empty for local
BACKUP_USER_SERVER="guilherme@10.1.1.5"

# Local config files
L_CONFIG_ROOT="$HOME/config/backup"
L_BACKUP_SOURCES_FILE="$L_CONFIG_ROOT/backup_sources"
L_BACKUP_EXCLUDE_FILE="$L_CONFIG_ROOT/backup_excludes"

# Remote paths for backup locations
R_BACKUP_DEST_DIR="/media/551597486755/backup"
R_LAST_BACKUP_LINK="$R_BACKUP_DEST_DIR"/last

# Run command in the backup server, if any
function rcmd() {
    if [ -n "$BACKUP_USER_SERVER" ]; then
        ssh $BACKUP_USER_SERVER "$@"
    else
        "$@"
    fi
}

# Convert a remote path to local path
function rtol() {
    if [ -n "$BACKUP_USER_SERVER" ]; then
        echo "${BACKUP_USER_SERVER}:$1"
    else
        echo "$1"
    fi
}

RSYNC_OPTS="--archive
            --executability
            --progress
            --hard-links
            --human-readable
            --numeric-ids
            --verbose"

if [ -f "$L_BACKUP_EXCLUDE_FILE" ]; then
    RSYNC_OPTS="$RSYNC_OPTS --exclude-from=$L_BACKUP_EXCLUDE_FILE"
fi

# Compute new backup dir
r_backup_dir="$R_BACKUP_DEST_DIR/$(date +%Y%m%d-%H%M)"
l_backup_dir=$(rtol "$r_backup_dir")

if rsync -q "$l_backup_dir" > /dev/null 2>&1; then
    echo "Backup dir '$r_backup_dir' already exists, aborting."
    exit 1
fi

while read backup_src to backup_dest; do
    rcmd mkdir -p "$r_backup_dir/$backup_dest"

    if ! rsync $RSYNC_OPTS --link-dest="$R_LAST_BACKUP_LINK/$backup_dest" "$backup_src" "$l_backup_dir/$backup_dest"; then
        echo "Failed to backup '$backup_src', aborting."
        exit 1
    fi
done < "$L_BACKUP_SOURCES_FILE"

# Assume $R_LAST_BACKUP_LINK is in the same dir as $r_backup_dir
# and create a relative symlink
rcmd ln -snvf "$(basename $r_backup_dir)" "$R_LAST_BACKUP_LINK"
