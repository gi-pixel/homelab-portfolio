#  Automated Multi-Node Homelab

This repository contains the architecture and automation scripts for my personal homelab. It demonstrates a **distributed system** approach, separating infrastructure services (Gateway) from application services (Production) across multiple nodes to ensure high availability and security.

##  Architecture Overview
The lab is architected across two primary nodes connected via a secure **Tailscale Mesh VPN**:

### **Node A: Infrastructure Gateway**
*Handles edge traffic, DNS filtering, security, and core utilities.*
* **Services:** * **Nginx Proxy Manager:** Reverse Proxy & SSL management.
    * **Pi-hole:** Network-wide DNS filtering.
    * **Vaultwarden:** Self-hosted secret management.
    * **OwnCloud:** Private file storage & syncing.
    * **Uptime Kuma:** Real-time service monitoring.
    * **MariaDB + phpMyAdmin:** Backend database management for infra services.

### **Node B: App Production**
*Dedicated host for high-resource user-facing applications.*
* **Services:** * **WordPress:** Production CMS for web development.
    * **MariaDB:** Isolated database for WordPress.

---

##  Project Structure
```text
homelab-portfolio/
├── infra-gateway/     # Infrastructure & Networking configs (Node A)
├── apps-production/   # Production application configs (Node B)
└── scripts/           # Automation & Management orchestrators
```
## Automation Toolkit
```text
Script    Function
master-install.sh    The Orchestrator. Runs system prep, deploys all containers, and runs health checks.
install-docker.shAutomates Docker Engine & Compose installation on fresh Ubuntu nodes.
sync-portfolio.shSyncs live configs to this repo while scrubbing passwords for security.
migrate-wp.shHandles data packaging and transfer between nodes via SSH/Tailscale.
check-health.shFast CLI-based status monitoring for all running services.
```
## Getting Started
 * Prerequisites
    * Ubuntu 22.04 or 24.04 LTS.
    * Tailscale installed and authenticated for inter-node communication.
 * One-Click DeploymentTo replicate this environment on a fresh server, clone the repository and run the master orchestrator:
```text
git clone [https://github.com/gi-pixel/homelab-portfolio.git](https://github.com/gi-pixel/homelab-portfolio.git)
cd homelab-portfolio
bash scripts/master-install.sh
```
## Security & Best Practices
 * Environment Variables: All sensitive data is managed via .env files which are strictly excluded from Git tracking.
 * Secret Scrubbing: The sync-portfolio.sh script uses sed patterns to automatically redact raw passwords from source code before any commit.
 * Reverse Proxy & SSL: SSL termination is handled via Tailscale Certificates integrated through Nginx Proxy Manager, ensuring encrypted internal traffic without exposing ports to the public internet.
   
Created by gi-pixel — Focused on DevOps and Infrastructure Automation.
