# UFW Firewall Configuration

## Objective
Configure UFW (Uncomplicated Firewall) on Ubuntu 22.04 to control 
inbound and outbound network traffic.

## Steps Taken

1. Installed and enabled UFW
2. Set default policies to deny incoming and allow outgoing
3. Allowed only necessary services and ports
4. Verified firewall rules and status

## Rules Applied
- Default incoming: DENY
- Default outgoing: ALLOW
- Allowed: SSH
- Allowed: HTTP
- Allowed: HTTPS

## Commands Used
- ufw enable
- ufw default deny incoming
- ufw default allow outgoing
- ufw allow ssh
- ufw status verbose

## Result
Firewall configured and active. Only essential ports open.
All other incoming traffic blocked by default.

## Tools Used
- UFW (Uncomplicated Firewall)
