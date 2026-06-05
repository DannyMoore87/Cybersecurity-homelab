# Suricata IDS Setup

## Objective
Install and configure Suricata as an intrusion detection system (IDS)
on Ubuntu 22.04 to monitor network traffic for suspicious activity.

## Steps Taken

1. Installed Suricata on Ubuntu 22.04
2. Configured Suricata to monitor the correct network interface
3. Updated rules using suricata-update
4. Tested Suricata with simulated network traffic
5. Reviewed alerts and logs

## Configuration Changes
File modified: /etc/suricata/suricata.yaml

Key settings applied:
- Set HOME_NET to lab network range
- Configured network interface for monitoring
- Enabled rule categories

## Rule Management
- Used suricata-update to download and update rulesets
- Verified rules loaded successfully on service start

## Log Files
- /var/log/suricata/fast.log - Alert log
- /var/log/suricata/eve.json - Detailed event log

## Result
Suricata successfully deployed as IDS. Network traffic monitored
in real time with alerts generated for suspicious activity.

## Tools Used
- Suricata - Intrusion detection system
- suricata-update - Rule management
