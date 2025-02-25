#!/bin/bash
# Variables
share_name="immich" # Name of Share
backup_date=$(date +%Y%m%d) # Date
mount_point="/mnt/user/Backups/zfs_mnt_temp/${share_name}" # Where to temporary mount the ZFS Snapshot
dest_dir="/mnt/user/Backups/automated_backup_${share_name}" # Where to output the backup archive

# Create snapshot
if ! zfs snapshot storage-a/${share_name}@backup-${backup_date}; then
    echo "Error: Failed to create snapshot"
    exit 1
fi

# Create mount directory
mkdir -p "$mount_point"

# Mount Snapshot
if ! mount -t zfs storage-a/${share_name}@backup-${backup_date} "$mount_point"; then
    echo "Error: Failed to mount snapshot"
    zfs destroy storage-a/${share_name}@backup-${backup_date}
    rmdir "$mount_point"
    exit 1
fi

# Setup backup variables
source_dir="$mount_point"
archive_name="${share_name}-backup-${backup_date}.tar.gz"  # Archive name includes share name
archive_path="${dest_dir}/${archive_name}"

# Create the backup archive
if ! tar -czvf "$archive_path" "$source_dir"; then
    echo "Error: Failed to create archive"
    umount "$mount_point"
    zfs destroy storage-a/${share_name}@backup-${backup_date}
    rmdir "$mount_point"
    exit 1
fi

echo "Backup created successfully at: $archive_path"

# Unmount Snapshot
if ! umount "$mount_point"; then
    echo "Error: Failed to unmount snapshot"
fi

# Destroy snapshot
if ! zfs destroy storage-a/${share_name}@backup-${backup_date}; then
    echo "Error: Failed to destroy snapshot"
fi

echo "Backup process completed."

## Clean Up
# 1. List backups, sorted by modification time (newest first):
backup_files=$(ls -t "$dest_dir/${share_name}-backup-*.tar.gz")
# 2. Count the number of backup files:
backup_count=$(echo "$backup_files" | wc -l)
# 3. Check if there are more than 3 backups:
if (( backup_count > 3 )); then
  # 4. Calculate the number of backups to delete:
  files_to_delete=$(( backup_count - 3 ))

  # 5. Delete the oldest backups (using tail to get the last 'n' lines):
  echo "Deleting oldest backups:"
  echo "$backup_files" | tail -n +$((files_to_delete + 1)) | while read file; do
    echo "Deleting: $file"
    rm "$file"
  done
fi
echo "Backup process completed and older backups cleaned up."

# create test file
touch $dest_dir/completed.txt
