k#!/bin/bash
# Description: Quick health check for all homelab containers

SERVICES=("pihole" "vaultwarden" "nginx-proxy-manager" "wordpress" "homepage" "uptime-kuma" "mariadb")

echo "--- Homelab Health Status ---"
echo "DATE: $(date)"
echo "----------------------------"

for container in "${SERVICES[@]}"; do
    STATUS=$(docker inspect -f '{{.State.Status}}' "$container" 2>/dev/null || echo "not found")
    
    if [ "$STATUS" == "running" ]; then
        echo "[UP]   $container"
    else
        echo "[DOWN] $container (Current State: $STATUS)"
    fi
done
