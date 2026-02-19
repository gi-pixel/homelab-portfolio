#!/bin/bash

# --- CONFIGURATION ---
SOURCE_DIR="$HOME/docker"
REPO_DIR="$HOME/homelab-portfolio"
LOG_FILE="$REPO_DIR/sync_log.txt"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

mkdir -p "$REPO_DIR"

log_message() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOG_FILE"
}

log_message "####----Starting portfolio sync..."

# List of folders to sync
SERVICES=("pihole" "vaultwarden" "nginx-proxy-manager" "uptime-kuma" "dashboard" "opencloud" "mariadb")

for SERVICE in "${SERVICES[@]}"; do
    SRC_FILE="$SOURCE_DIR/$SERVICE/docker-compose.yml"
    DEST_FOLDER="$REPO_DIR/infra-gateway/$SERVICE"
    
    mkdir -p "$DEST_FOLDER"

    if [ -f "$SRC_FILE" ]
    then
        # Scrub passwords and redirect to the new file
        sed -E 's/(PASSWORD|PASS|SECRET|TOKEN):.*/\1: ${SET_IN_ENV_FILE}/gI' "$SRC_FILE" > "$DEST_FOLDER/docker-compose.yml"
        log_message "SUCCESS: Copied and scrubbed $SERVICE"
    else
        log_message "WARNING: $SRC_FILE not found"
    fi
done

# Handle WordPress located on server B
WP_SRC="$HOME/wordpress-site/docker-compose.yml"
WP_DEST="$REPO_DIR/apps-production/wordpress"
mkdir -p "$WP_DEST"

if [ -f "$WP_SRC" ]
then
    sed -E 's/(PASSWORD|PASS|SECRET|TOKEN):.*/\1: ${SET_IN_ENV_FILE}/gI' "$WP_SRC" > "$WP_DEST/docker-compose.yml"
    log_message "SUCCESS: Copied and scrubbed WordPress"
else
    log_message "WARNING: $WP_SRC not found"
fi

log_message "####-----Sync completed------####"
