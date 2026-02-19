#!/bin/bash
# Description: Packages WordPress data and moves it to a remote node
# Usage: ./migrate-wp-server-a-to-b.sh <target_server_ip>

TARGET_IP=$1
SOURCE_DIR="$HOME/wordpress-site"
BACKUP_FILE="/tmp/wp_migration_$(date +%F).tar.gz"
USER={USER_NAME}

if [ -z "$TARGET_IP" ]; then
    echo "Error: Please provide the target server IP address."
    echo "Usage: $0 100.x.x.x"
    exit 1
fi

echo "Step 1: Compressing WordPress source data..."
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIR" .

echo "Step 2: Transferring data to Server B ($TARGET_IP)..."
# Assumes SSH key is already configured
scp "$BACKUP_FILE" "$USER@$TARGET_IP:/tmp/"

echo "Step 3: Cleaning up local temporary backup..."
rm "$BACKUP_FILE"

echo "Success! The migration package has been sent to the target server."
