# 🛡️ Cybersecurity Home Lab

> A multi-environment cybersecurity lab built for hands-on learning in offensive security, defensive security, and enterprise Active Directory management.

**Platform:** VirtualBox | **OS:** Windows 11 Host | **Network:** Isolated host-only segments

---

## 🗂️ Lab Overview

This repository documents my ongoing cybersecurity home lab across three parallel tracks — penetration testing, defensive monitoring, and Active Directory. Each lab is isolated, documented, and built with portfolio and career development in mind.

```
Cybersecurity-homelab/
│
├── labs/
│   ├── metasploitable2/        # Kali vs Metasploitable 2 — Pentest Lab
│   ├── defensive-ubuntu/       # Ubuntu 22.04 hardened defensive machine
│   └── active-directory/       # Windows Server 2022 AD DS lab
│
└── README.md                   # This file
```

---

## ⚔️ Lab 1 — Penetration Testing (Kali vs Metasploitable 2)

**Network:** `192.168.56.0/24` (host-only)  
**Attacker:** Kali Linux  
**Target:** Metasploitable 2 (`192.168.56.102`)  
**Status:** ✅ Complete — documented

### What Was Covered
- Full Nmap reconnaissance (23 open ports mapped)
- Network service exploitation: vsftpd, Samba, MySQL, PostgreSQL, Telnet, Bindshell
- Web application attacks via DVWA: SQL Injection, XSS (Reflected & Stored), Command Injection, LFI
- Post-exploitation: user enumeration, password hash dumping, privilege escalation
- Tool usage: Metasploit, Netcat, Hydra, manual browser attacks

### Results
| Metric | Value |
|--------|-------|
| Attacks Attempted | 15 |
| Successful | 11 |
| Root Shells Obtained | 5 |
| Password Hashes Cracked | 6 |

📄 **[Full Lab Report →](labs/metasploitable2/README.md)**

---

## 🛡️ Lab 2 — Defensive Security (Hardened Ubuntu 22.04)

**Network:** `192.168.56.0/24` (same hacking_lab network)  
**Machine:** Ubuntu 22.04 LTS  
**Status:** 🔧 In Progress

### Configuration
- **Fail2ban** — brute force protection, SSH/Apache ban rules
- **Suricata** — network IDS/IPS with custom rules
- **UFW** — host-based firewall with allowlist
- **AIDE** — file integrity monitoring
- **auditd** — system call auditing
- **Apache** — web server for attack surface
- **Lynis** — security audit scoring

### Goal
Run structured attacks from Kali against this machine and capture:
- Fail2ban ban logs
- Suricata alerts
- UFW drop logs
- AIDE integrity violations
- auditd syscall traces

📄 **[Defensive Lab Documentation →](labs/defensive-ubuntu/README.md)** *(coming soon)*

---

## 🏢 Lab 3 — Active Directory (Windows Server 2022)

**Network:** `192.168.57.0/24` (host-only)  
**Domain Controller:** `DC01` — `192.168.57.10` — domain `lab.local`  
**Status:** 🔧 In Progress

### Configuration
- Windows Server 2022 Domain Controller
- OUs: Workstations, IT, HR
- Domain users: `jsmith`, `jdoe`
- Windows 11 Enterprise clients being joined to domain

### Planned Attack Scenarios
- Kerberoasting
- Pass-the-hash
- BloodHound AD enumeration
- GPO abuse
- Lateral movement simulation

📄 **[Active Directory Lab Documentation →](labs/active-directory/README.md)** *(coming soon)*

---

## 🧰 Tools & Technologies

| Category | Tools |
|----------|-------|
| Hypervisor | VirtualBox |
| Attacker OS | Kali Linux |
| Exploitation | Metasploit Framework, Netcat |
| Web Attacks | Manual browser, sqlmap, Burp Suite |
| Password Attacks | Hydra, John the Ripper, Hashcat |
| Recon | Nmap, Nikto, enum4linux |
| Defensive | Fail2ban, Suricata, UFW, AIDE, auditd, Lynis |
| AD Attacks | BloodHound, Impacket *(planned)* |
| Scripting | Bash, Python, Node.js |
| Reporting | Custom Node.js/docx report generator |

---

## 📁 Repository Structure

```
labs/
├── metasploitable2/
│   ├── README.md              # Full pentest writeup
│   └── Pentest_Report.pdf     # Formal PDF report
│
├── defensive-ubuntu/
│   ├── README.md              # Setup & hardening guide
│   ├── configs/               # Fail2ban, Suricata, UFW configs
│   └── attack-results/        # Captured logs and alerts
│
└── active-directory/
    ├── README.md              # AD setup guide
    ├── topology.png           # Network diagram
    └── attack-scenarios/      # Attack documentation
```

---

## 🎯 Goals

- [x] Build isolated pentest lab (Kali vs Metasploitable 2)
- [x] Complete and document full pentest session with formal report
- [x] Set up hardened defensive Ubuntu machine
- [ ] Run attack-defense scenarios and capture defensive telemetry
- [ ] Build and document Active Directory lab
- [ ] Practice AD attack techniques (Kerberoasting, Pass-the-hash)
- [ ] Earn Security+ / CEH certification

---

## 📬 Connect

If you're a recruiter, hiring manager, or fellow learner feel free to reach out!

**GitHub:** [DannyMoore87](https://github.com/DannyMoore87)

---

*All lab work is conducted in isolated virtual environments for educational purposes only.*
