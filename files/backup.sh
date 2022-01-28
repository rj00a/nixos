#!/usr/bin/env sh

set -e

backup_drive=/dev/disk/by-label/Backup
backup_mnt="$(mktemp -d)"

echo "Mounting $backup_drive to $backup_mnt"

sudo mount "$backup_drive" "$backup_mnt"

last_backup="$backup_mnt/last-backup.txt"

# Clear last backup file
: > "$last_backup"

t() {
    "$@" | tee -a "$last_backup"
}

t echo "==== Copying Home Directory ===="
t rsync -a --delete --progress --stats ~/ "$backup_mnt/homedir" \
    --exclude=.cache \
    --exclude=.ccache \
    --exclude=.local/share/Trash \
    --exclude=.local/share/Steam \
    --exclude=.rustup \
    --exclude=.cargo

t echo "==== Copying Bulk Storage ===="
t rsync -a --delete --progress --stats /mnt/bulk/ "$backup_mnt/bulk" \
    --exclude=lost+found \
    --exclude=.Trash-1000

t echo "==== Copying Shared Storage ===="
t rsync -a --delete --progress --stats /mnt/bulk/ "$backup_mnt/shared"

t echo "==== Copying Boot Partition ===="
t rsync -a --delete --progress --stats /boot/ "$backup_mnt/boot"

t echo "==== Unmounting $backup_mnt ===="

sudo umount "$backup_mnt"

echo 'Done!'
