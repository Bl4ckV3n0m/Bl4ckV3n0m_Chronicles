#!/bin/bash

set -e

echo "========================================"
echo "🧠 Bl4ck V3n0m's System Recon - BASH Mode"
echo "========================================"
echo

# 🖥️ CPU Info
echo "[🧠] CPU INFO"
lscpu | grep -E 'Model name|Socket|Thread|CPU\(s\)'
echo "CPU Load: $(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')%"
echo

# 🎮 GPU Info (NVIDIA or integrated)
echo "[🎮] GPU INFO"
if command -v nvidia-smi &> /dev/null; then
  nvidia-smi --query-gpu=name,memory.total,memory.free,memory.used,utilization.gpu --format=csv
else
  lspci | grep -i vga || echo "No GPU info found."
fi
echo

# 💾 RAM Info
echo "[💾] RAM INFO"
free -h
echo

# 📀 Disk Info
echo "[📀] DISK INFO"
df -hT | grep -v tmpfs
echo

# 🧬 Motherboard Info (Linux Only)
echo "[🧬] MOTHERBOARD INFO"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo dmidecode -t baseboard | grep -E "Manufacturer|Product|Serial|Version"
else
  echo "Motherboard info not supported on this OS."
fi
echo

# 🌐 Network Info
echo "[🌐] NETWORK INFO"
hostname=$(hostname)
local_ip=$(hostname -I | awk '{print $1}')
echo "Hostname: $hostname"
echo "Local IP: $local_ip"

# Check internet connectivity
if ping -c 1 1.1.1.1 &> /dev/null; then
  echo "Internet: Connected"
else
  echo "Internet: Disconnected"
fi
echo

# ⚡ Connection Type (Ethernet/WiFi)
echo "[📡] CONNECTION TYPE"
if nmcli device status &> /dev/null; then
  nmcli device status | grep connected
else
  ip a | grep -E "state UP|inet " | grep -v lo
fi
echo

# 🚀 Internet Speed Test (Requires speedtest-cli)
if command -v speedtest &> /dev/null; then
  echo "[🚀] SPEEDTEST"
  speedtest --simple
else
  echo "[!] speedtest-cli not found. Install with: sudo apt install speedtest-cli"
fi
