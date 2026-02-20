#!/bin/bash
# =================================================================
# HOMELAB MASTER BOOTSTRAP SCRIPT
# Description: Executes the full lab setup from a single folder.
# =================================================================

# Colors for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' 

echo -e "${BLUE} Starting Homelab Master Installation...${NC}"

# Get the directory where this script is located
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

# 1. System Prep (Run the Docker Install script)
echo -e "\n${GREEN}[1/3] Preparing System & Installing Docker...${NC}"
if [ -f "$SCRIPT_DIR/setup.sh" ]; then
    bash "$SCRIPT_DIR/setup.sh"
else
    echo "Error: setup.sh not found in $SCRIPT_DIR"
fi

# 2. Deploy All Docker Containers
# This moves to the root of the repo and finds all docker-compose files
echo -e "\n${GREEN}[2/3] Deploying All Docker Containers (Infra & Apps)...${NC}"
REPO_ROOT=$(dirname "$SCRIPT_DIR")

# Find every docker-compose.yml file and bring it up
find "$REPO_ROOT" -name "docker-compose.yml" | while read -r compose_file; do
    dir=$(dirname "$compose_file")
    echo "Processing $dir..."
    (cd "$dir" && docker compose up -d)
done

# 3. Final Health Check
echo -e "\n${GREEN}[3/3] Running Initial Health Check...${NC}"
if [ -f "$SCRIPT_DIR/check-health.sh" ]; then
    bash "$SCRIPT_DIR/health-check.sh"
else
    echo "check-health.sh not found, skipping final check."
fi

echo -e "\n${BLUE} All processes complete! Your homelab is now live.${NC}"
