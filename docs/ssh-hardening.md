# SSH Hardening

## Objective
Secure the SSH service on Ubuntu 22.04 to prevent unauthorized access.

## Steps Taken

1. Disabled root login via SSH
2. Disabled password authentication (key-based only)
3. Changed default SSH port
4. Limited SSH access to specific users
5. Configured idle timeout settings

## Configuration Changes
File modified: /etc/ssh/sshd_config

Key settings applied:
- PermitRootLogin no
- PasswordAuthentication no
- MaxAuthTries 3
- ClientAliveInterval 300
- ClientAliveCountMax 0

## Result
SSH service hardened against brute force and unauthorized root access.
Verified changes by restarting the SSH service and testing connectivity.

## Tools Used
- OpenSSH
- UFW (to restrict SSH port access)
