#Automated Multi-Node Homelab

This repository contains the architecture and automation scripts for my personal homelab. 
It demonstrates a **distributed system** approach, separating infrastructure services (Gateway) from application services (Production) across multiple nodes.

#Architecture Overview
The lab is split into two primary roles connected via a Tailscale Mesh VPN:
Node A (Infrastructure Gateway): Handles incoming traffic, DNS filtering, and security.
    Services: Nginx Proxy Manager (Reverse Proxy), Pi-hole (DNS), Vaultwarden (Secret Management),opencloud (File Storage), uptime-kuma(Monitoring) maridb+phpmyadmin.
Node B (App Production): Dedicated host for user-facing applications.
    Services: WordPress, MariaDB.

 ##Project Structure
```text
homelab-portfolio/
├── infra-gateway/      # Infrastructure & Networking containers (Node A)
├── apps-production/    # Production application containers (Node B)
└── scripts/            # Automation & Management orchestrators
```

##Script	        Function
```text
master-install.sh	The Orchestrator. Runs system prep, deploys all containers, and runs health checks.
install-docker.sh	Automates Docker Engine and Compose installation on fresh Ubuntu nodes.
sync-portfolio.sh	A maintenance tool that syncs live configs to this repo while scrubbing passwords for security.
migrate-wp.sh	    Handles data packaging and transfer between nodes via secure SSH/Tailscale.
check-health.sh	    Fast CLI-based status monitoring for all Docker containers.
```

##Getting Started
    ### *Prerequisites
```text
        Ubuntu 22.04 or 24.04 LTS.
        Tailscale installed for inter-node communication.
 ```       
### *One-Click Deployment
    ```text
        To replicate this environment on a fresh server, clone the repository and run the master orchestrator:
        git clone (https://github.com/gi-pixel/homelab-portfolio.git)
        cd homelab-portfolio
        bash scripts/master-install.sh
    ```
##Security & Best Practices

*Environment Variables: All sensitive data is managed via .env files (excluded from Git).
*Secret Scrubbing: The sync-portfolio.sh script uses sed patterns to ensure no raw passwords are accidentally committed to the repository from my homelab source code.
*Reverse Proxy: SSL termination is handled via tailscale cert through Nginx Proxy Manager(you should look it up).

