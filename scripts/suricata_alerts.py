#!/usr/bin/env python3
# Suricata Alert Parser
# Author: Danny
# Purpose: Parse eve.json and generate a security alert summary

import json
from datetime import datetime
from collections import Counter

EVE_LOG = "/var/log/suricata/eve.json"

def parse_alerts():
    alerts = []
    try:
        with open(EVE_LOG, "r", errors="replace") as f:
            for line in f:
                try:
                    event = json.loads(line)
                    if event.get("event_type") == "alert":
                        alerts.append({
                            "timestamp": event.get("timestamp", ""),
                            "signature": event["alert"].get("signature", ""),
                            "severity": event["alert"].get("severity", ""),
                            "src_ip": event.get("src_ip", ""),
                            "dest_ip": event.get("dest_ip", ""),
                            "dest_port": event.get("dest_port", "")
                        })
                except json.JSONDecodeError:
                    continue
    except FileNotFoundError:
        print(f"Error: Could not find {EVE_LOG}")
        return []
    return alerts

def print_report(alerts):
    print("="*50)
    print("  SURICATA ALERT SUMMARY")
    print(f"  Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("="*50)

    print(f"\nTotal Alerts: {len(alerts)}")

    print("\n--- ALERTS BY SIGNATURE ---")
    sigs = Counter(a["signature"] for a in alerts)
    for sig, count in sigs.most_common():
        print(f"  {count:>4}x  {sig}")

    print("\n--- ALERTS BY SOURCE IP ---")
    src_ips = Counter(a["src_ip"] for a in alerts)
    for ip, count in src_ips.most_common():
        print(f"  {count:>4}x  {ip}")

    print("\n--- ALERTS BY DESTINATION PORT ---")
    ports = Counter(str(a["dest_port"]) for a in alerts)
    for port, count in ports.most_common(10):
        print(f"  {count:>4}x  Port {port}")

    print("\n--- MOST RECENT ALERTS ---")
    for alert in alerts[-5:]:
        print(f"  {alert['timestamp']} | {alert['src_ip']} -> {alert['dest_ip']}:{alert['dest_port']} | {alert['signature']}")

    print("\n" + "="*50)
    print("  END OF REPORT")
    print("="*50)

if __name__ == "__main__":
    alerts = parse_alerts()
    if alerts:
        print_report(alerts)
    else:
        print("No alerts found.")
