#!/bin/bash
# System Health Check Script
# Author: Danny
# Purpose: Daily security health check

echo "======================================"
echo "  SYSTEM HEALTH CHECK"
echo "  $(date)"
echo "======================================"

echo ""
echo "--- DISK USAGE ---"
df -h | grep -v tmpfs

echo ""
echo "--- MEMORY USAGE ---"
free -h

echo ""
echo "--- LOGGED IN USERS ---"
who

echo ""
echo "--- LAST 5 LOGINS ---"
last | head -5

echo ""
echo "--- FAILED LOGIN ATTEMPTS ---"
sudo grep "Failed password" /var/log/auth.log | wc -l | xargs echo "Total failed logins:"

echo ""
echo "--- SURICATA ALERTS TODAY ---"
sudo grep -a '"event_type":"alert"' /var/log/suricata/eve.json | wc -l | xargs echo "Total alerts:"

echo ""
echo "--- TOP 5 PROCESSES BY CPU ---"
ps aux --sort=-%cpu | head -6

echo ""
echo "======================================"
echo "  END OF REPORT"
echo "======================================"
