# Lynis Security Auditing

## Objective
Use Lynis to audit and harden the Ubuntu 22.04 system security configuration
across multiple rounds of testing and remediation.

## Steps Taken

1. Installed Lynis on Ubuntu 22.04
2. Ran initial security audit to establish baseline score
3. Reviewed audit findings and applied recommended hardening steps
4. Ran second audit to measure improvement
5. Applied additional hardening based on second round findings

## Hardening Applied
- Configured kernel hardening parameters via sysctl
- Disabled unused services and modules
- Strengthened password policies
- Configured audit logging
- Enabled file integrity monitoring
- Hardened SSH configuration
- Configured UFW firewall rules

## Results
- Round 1 baseline score established
- Round 2 showed measurable improvement in hardening index
- System hardening index increased across both rounds

## Commands Used
- lynis audit system
- lynis show details [test-id]

## Tools Used
- Lyni
