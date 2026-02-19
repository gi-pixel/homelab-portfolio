# Automated Multi-Node Homelab

This repository contains the architecture and automation scripts for my personal homelab. 
It demonstrates a **distributed system** approach, separating infrastructure services (Gateway) from application services (Production) across multiple nodes.

## Architecture Overview
The lab is split into two primary roles connected via a Tailscale Mesh VPN:

Node A (Infrastructure Gateway): Handles incoming traffic, DNS filtering, and security.
    Services: Nginx Proxy Manager (Reverse Proxy), Pi-hole (DNS), Vaultwarden (Secret Management),opencloud (File Storage), uptime-kuma(Monitoring) maridb+phpmyadmin.
Node B (App Production): Dedicated host for user-facing applications.
    Services: WordPress, MariaDB.

##  Project Structure
text
homelab-portfolio/
├── infra-gateway/      # Infrastructure & Networking containers (Node A)
├── apps-production/    # Production application containers (Node B)
└── scripts/            # Automation & Management orchestrators
