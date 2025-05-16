# 💀 Bl4ckV3n0m's Chronicles: Code Arsenal

Welcome to the **official companion repository** to the underground hacking opus:

> **_"Bl4ck V3n0m's Chronicles: Behind the Mask of Hackers, Crypto Crimes, & Digital Warfare"_**

This repo contains the **full payload arsenal, scripts, recon tools, exploit templates, and dorking strategies** referenced throughout the book — plus bonus content to empower readers with **real-world operational clarity**.

> ⚠️ **READ THIS FIRST**
> All scripts, payloads, and dorks are intended **strictly for educational, research, and defensive security auditing**. Do **not** use against systems/networks you don’t own or have explicit permission to test. This repo is a weapon. **Use it responsibly.**

---

## 📁 Repository Contents

| Folder / File               | Purpose                                                |
|-----------------------------|---------------------------------------------------------|
| `payloads/`                | Real-world payloads (XSS, SQLi, LFI, RCE, etc.)        |
| `scripts/`                 | Bash/Python tools for recon, exfil, mining, and more   |
| `dorks/`                   | Google Dorks sorted by attack type                     |
| `cryptojacking/`           | Resource hijacking scripts for Monero, XMR, etc.       |
| `wifi_attacks/`            | WiFi Pineapple setups, sniffers, handshakes            |
| `bluetooth_exploits/`      | BT hijacking, beacon spoofing, MITM tricks             |
| `sqlmap_templates/`        | Weaponized SQLMap commands with tamper techniques      |
| `obfuscation/`             | Payload obfuscation methods (`base64`, hex, JS tricks) |
| `anti_forensics/`          | Wiping trails, hiding processes, avoiding detection    |
| `bypass_payloads/`         | AV/EDR/UAC/Firewall bypass attempts                    |
| `book_examples/`           | Scripts/code copied directly from book chapters        |
| `recon_tools/`             | Custom OSINT, WHOIS, port scan scripts                 |
| `defensive/`               | Detection, log analysis, and mitigation scripts        |

---

## 🔥 Sample Use Cases

### ▸ Recon Dorking
```bash
inurl:login intitle:"admin panel"
site:*.gov filetype:xls intext:@gmail.com
```

### ▸ SQL Injection Attack
```bash
sqlmap --url "http://target.com/item.php?id=1" --risk=3 --level=5 --dbs --tamper=space2comment
```

### ▸ CryptoJacking Script
```bash
bash cryptojacking/start_xmrig.sh
```

---

## 🛡️ Ethical Warning
This repo contains **real tactics used by threat actors** — recreated for **education and defense**. Every file here is a **lesson, not a weapon** — unless you choose otherwise. 

By cloning this repository, you accept:
- You will only use this on **legal targets** (your own servers, labs, CTFs)
- You take full responsibility for how you use this code

> ⚠️ Your IP is logged by GitHub. Don’t be stupid. Learn, don’t burn.

---

## 📖 Related Book
If you found this repo first, grab the full book:
📘 **"Bl4ck V3n0m’s Chronicles"** — [Link coming soon]

Covers:
- Real hacker psychology
- Recon, Enumeration, Privilege Escalation
- Crypto theft, WiFi hijacks, and digital laundering
- AV/EDR evasion, anti-forensics, and ransomware theory

---

## 👤 Author
**Bl4ck V3n0m** (a.k.a. @z3r0s3c)
- GitHub: [github.com/Bl4ckV3n0m](https://github.com/Bl4ckV3n0m)
- Email: blackvenom@greynodesecurity.com
- Book: _"Bl4ck V3n0m’s Chronicles"_

> "Expose everything. Hide nothing. Master both." 🕶️

---

## 📌 Future Additions
- `lateral_movement/`
- `custom_exploits/`
- `windows_bypass/`
- `c2_infrastructure/`
- `automation_toolkit/`

---

## 🧠 Final Note
This repo is a digital field manual — raw, relentless, and real. Built for warriors of the wire, by one who’s walked both sides of the line.

Stay silent. Move loud. Hack everything you own.
