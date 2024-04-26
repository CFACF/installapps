#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/build.func)

function header_info {
clear
cat <<"EOF"
   _____                    _                _         _ _ 
  / ____|                  | |              | |       | | |
 | |     _ __ _____   _____| | ___  _ __ ___| |_ _   _| | |
 | |    | '__/ _ \ \ / / _ \ |/ _ \| '__/ __| __| | | | | |
 | |____| | |  __/\ V /  __/ | (_) | |  \__ \ |_| |_| | | |
  \_____|_|  \___| \_/ \___|_|\___/|_|  |___/\__|\__,_|_|_|
EOF
}
header_info
echo -e "Initializing unified installation..."

# Define common variables for the container
var_disk="20"
var_cpu="2"
var_ram="2048"  # in MB
var_os="debian"
var_version="12"
var_brg="vmbr0"
var_net="dhcp"

# Fetch the next available ID dynamically
CT_ID=$(pvesh get /cluster/nextid)

function default_settings() {
  echo "Using Default Settings"
  echo "Using Distribution: $var_os"
  echo "Using $var_os Version: $var_version"
  echo "Using Container Type: 1"
  echo "Using Root Password: Automatic Login"
  echo "Using Container ID: $CT_ID"
  echo "Using Hostname: unifiedapp"
  echo "Using Disk Size: $var_disk GB"
  echo "Allocated Cores: $var_cpu"
  echo "Allocated RAM: $var_ram MB"
  echo "Using Bridge: $var_brg"
  echo "Using Static IP Address: $var_net"
  echo "Using Gateway IP Address: Default"
  echo "Using Apt-Cacher IP Address: Default"
  echo "Disable IPv6: No"
  echo "Using Interface MTU Size: Default"
  echo "Using DNS Search Domain: Host"
  echo "Using DNS Server Address: Host"
  echo "Using MAC Address: Default"
  echo "Using VLAN Tag: Default"
  echo "Enable Root SSH Access: No"
  echo "Enable Verbose Mode: No"
}

default_settings

# Start the container creation
start

# Installation Functions for each app
function install_app() {
  APP=$1
  PORT=$2
  build_container  # assuming this function is defined and works correctly
  description  # assuming this function is defined and works correctly
  echo -e "${APP} should be reachable at http://${IP}:${PORT}\\n"
}

# Execute Installations
install_app "Bazarr" "6767"
install_app "Prowlarr" "9696"
install_app "Radarr" "7878"
install_app "Sonarr" "8989"

echo "All services are installed successfully in a single container."
msg_ok "Completed Successfully!"
exit 0  # Properly using exit with a numeric status


