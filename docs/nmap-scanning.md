# Nmap Vulnerability Scanning

## Objective
Use Nmap to perform network reconnaissance and vulnerability scanning
against Metasploitable 2 in a controlled lab environment.

## Target
Metasploitable 2 - Intentionally vulnerable virtual machine
used for penetration testing practice.

## Steps Taken

1. Identified target IP address on the lab network
2. Performed host discovery scan
3. Performed service and version detection scan
4. Performed OS detection scan
5. Ran vulnerability scanning scripts
6. Documented findings

## Scans Performed
- Host discovery: nmap -sn [target]
- Port scan: nmap -sS [target]
- Service detection: nmap -sV [target]
- OS detection: nmap -O [target]
- Full scan: nmap -A [target]
- Vulnerability scripts: nmap --script vuln [target]

## Findings
Metasploitable 2 revealed multiple open ports and vulnerable services
including FTP, SSH, Telnet, HTTP, and SMB with known exploitable versions.

## Result
Successfully identified attack surface of target machine.
Findings used to understand common vulnerabilities and 
the importance of proper system hardening.

## Tools Used
- Nmap - Network scanner
- Metasploitable 2 - Vulnerable target machine
