#!/bin/bash
# User Audit Script
# Author: Danny
# Purpose: Audit all user accounts and login activity

echo "======================================"
echo "  USER ACCOUNT AUDIT"
echo "  $(date)"
echo "======================================"

echo ""
echo "--- ALL SYSTEM USERS (UID 1000+) ---"
awk -F: '$3 >= 1000 && $3 != 65534 {print $1, "| UID:", $3, "| Shell:", $7}' /etc/passwd

echo ""
echo "--- USERS WITH SUDO PRIVILEGES ---"
grep -Po '^sudo.+:\K.*$' /etc/group | tr ',' '\n' | xargs -I{} echo "  {}"

echo ""
echo "--- LAST LOGIN FOR EACH USER ---"
lastlog | grep -v "Never\|Username"

echo ""
echo "--- CURRENTLY LOGGED IN ---"
who

echo ""
echo "--- ACCOUNTS WITH EMPTY PASSWORDS ---"
sudo awk -F: '($2 == "") {print "WARNING: " $1 " has no password!"}' /etc/shadow

echo ""
echo "--- RECENTLY MODIFIED PASSWD FILE ---"
ls -la /etc/passwd /etc/shadow /etc/sudoers

echo ""
echo "======================================"
echo "  END OF AUDIT"
echo "======================================"
