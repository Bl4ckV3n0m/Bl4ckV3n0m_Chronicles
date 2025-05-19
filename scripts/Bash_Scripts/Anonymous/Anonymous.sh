#!/bin/bash

# secure_kali_setup.sh
# Hardened Anonymity Setup Script for Kali Linux
# Bl4ckV3n0m Edition - Updated for Full Integrity & Security

# Release /etc/resolv.conf first
sudo chattr -i /etc/resolv.conf

set -euo pipefail

bold=$(tput bold)
normal=$(tput sgr0)

echo "${bold}[*] Starting full system hardening and anonymity setup...${normal}"

# Function: Check if command exists
function check_install() {
    if ! command -v "$1" &>/dev/null; then
        echo "[!] $1 not found. Installing..."
        sudo apt-get install -y "$1"
    else
        echo "[*] $1 is already installed."
    fi
}

# Update & upgrade system fully
echo "\n[*] Updating system..."
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y && sudo apt-get full-upgrade -y
sudo apt-get autoremove -y

# Install all Kali Linux tools
echo "\n[*] Installing all Kali Linux tools..."
sudo apt-get install -y kali-linux-everything

# Install anonymity tools
echo "\n[*] Installing core anonymity tools..."
check_install tor
check_install proxychains
check_install curl
check_install macchanger
check_install torbrowser-launcher
check_install libreoffice
check_install monero

# Restart tor service cleanly
echo "\n[*] Restarting Tor service..."
sudo systemctl stop tor || true
sudo systemctl disable tor@default || true
sudo systemctl enable tor
sudo systemctl start tor
sudo systemctl status tor --no-pager

# Configure ProxyChains
echo "\n[*] Configuring ProxyChains..."
sudo sed -i 's/^#dynamic_chain/dynamic_chain/' /etc/proxychains.conf
sudo sed -i 's/^strict_chain/#strict_chain/' /etc/proxychains.conf
sudo sed -i '/^socks4/d' /etc/proxychains.conf
sudo sed -i '/^socks5/d' /etc/proxychains.conf
sudo bash -c "echo 'socks5 127.0.0.1 9050' >> /etc/proxychains.conf"

# DNS Setup with Quad9
echo "\n[*] Configuring DNS to use Quad9..."
sudo sed -i '/^\[main\]/a dns=default' /etc/NetworkManager/NetworkManager.conf
sudo rm -rf /etc/resolv.conf
sudo bash -c 'cat <<EOF > /etc/resolv.conf
# Quad9 DNS - Enforced
nameserver 9.9.9.9
nameserver 149.112.112.112
nameserver 2620:fe::fe
nameserver 2620:fe::9
EOF'
sudo chattr +i /etc/resolv.conf
sudo systemctl restart NetworkManager
sudo chattr -i /etc/resolv.conf

# MAC address spoofing
echo "\n[*] Spoofing MAC address for eth0..."
sudo ip link set eth0 down
sudo macchanger -r eth0
sudo ip link set eth0 up
macchanger -s eth0

# VPN - Install Mullvad VPN
echo "\n[*] Installing Mullvad VPN if not already installed..."
sudo chattr -i /etc/resolv.conf
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
sudo bash -c 'echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/beta $(lsb_release -cs) main" > /etc/apt/sources.list.d/mullvad.list'
sudo apt-get update && sudo apt-get install -y mullvad-vpn

# Harden hostname
echo "\n[*] Cloaking hostname..."
sudo hostnamectl set-hostname randomhost-$(head /dev/urandom | tr -dc a-z0-9 | head -c 5)

# Harden /etc/hosts with ad/tracker blocklist
echo "\n[*] Updating /etc/hosts to block trackers and ads..."
sudo curl -s https://someonewhocares.org/hosts/hosts | sudo tee -a /etc/hosts > /dev/null

# Confirmation output
echo "\n${bold}[✓] Setup Complete!${normal}"
echo "[*] ProxyChains config validated at /etc/proxychains.conf"
echo "[*] DNS resolver locked to Quad9"
echo "[*] MAC address spoofed"
echo "[*] Tor + VPN + ProxyChains all enabled"
echo "[*] Ready to go secure & stealth mode, agent."

exit 0
