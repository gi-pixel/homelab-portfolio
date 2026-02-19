#!/bin/bash
# Server A Migration: Stop, Compress, and Send


REMOTE_USER={USER}
REMOTE_IP={REMOTE_SERVER_IP}
WP_DATA_PATH="./wordpress_data_folder"
DB_DATA_PATH="./mariadb_data_folder"


echo "### Starting Migration from Server A ###"

# 1. Stop the WordPress containers
echo "Stopping containers..."
docker stop wordpress-app wp-db

# 2. Compress the data
echo "Compressing data folders..."
tar -cvzf wp_migration.tar.gz $WP_DATA_PATH $DB_DATA_PATH

# 3. Send to Server B using the SSH Key
echo "Sending data to Server B..."
scp wp_migration.tar.gz ${REMOTE_USER}@${REMOTE_IP}:~/wordpress-site/

echo "### Migration Sent! Now go to Server B to extract. ###"
