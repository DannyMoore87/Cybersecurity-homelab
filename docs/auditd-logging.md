
# auditd Audit Logging

## Objective
Configure auditd on Ubuntu 22.04 to track and record system events
for security monitoring and recordkeeping.

## Steps Taken

1. Installed and enabled auditd service
2. Configured audit rules to monitor critical files and directories
3. Monitored user activity and authentication events
4. Reviewed audit logs for suspicious activity
5. Configured log rotation and retention

## Audit Rules Applied
- Monitored /etc/passwd and /etc/shadow for changes
- Monitored /etc/sudoers for modification
- Tracked all sudo command usage
- Logged all user login and logout events
- Monitored changes to system configuration files

## Key Files
- /etc/audit/auditd.conf - Main configuration file
- /etc/audit/rules.d/audit.rules - Audit rules file
- /var/log/audit/audit.log - Audit log output

## Commands Used
- auditctl -l (list active rules)
- ausearch -m USER_LOGIN (search login events)
- aureport (generate audit reports)

## Result
System activity logging configured and active. All critical file
changes and user actions recorded for review and compliance.

## Tools Used
- auditd - Linux audit daemon
- auditctl - Audit rule management
- ausearch - Audit log search
- aureport - Audit report generation
