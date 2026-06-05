Type this in:
# AIDE File Integrity Monitoring

## Objective
Install and configure AIDE (Advanced Intrusion Detection Environment)
on Ubuntu 22.04 to detect unauthorized changes to system files.

## Steps Taken

1. Installed AIDE on Ubuntu 22.04
2. Configured AIDE to monitor critical system directories
3. Initialized the AIDE database to establish a baseline
4. Ran AIDE check to compare current state against baseline
5. Reviewed AIDE report for any changes detected

## Directories Monitored
- /etc - System configuration files
- /bin - Essential system binaries
- /sbin - System administration binaries
- /usr - User programs and utilities
- /var/log - System log files

## Key Files
- /etc/aide/aide.conf - Main configuration file
- /var/lib/aide/aide.db - Baseline database
- /var/log/aide/aide.log - AIDE report log

## Commands Used
- aide --init (initialize baseline database)
- aide --check (compare against baseline)
- aide --update (update database after verified changes)

## Result
File integrity monitoring configured and active. Any unauthorized
changes to monitored files will be detected and logged for review.

## Tools Used
- AIDE - Advanced Intrusion Detection Environment
