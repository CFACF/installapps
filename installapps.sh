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

# Container creation settings
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

# Start the container creation
start

# Installation Functions
function install_bazarr() {
  APP="Bazarr"
  build_container
  description
  echo -e "${APP} should be reachable at http://${IP}:6767\\n"
}

function install_prowlarr() {
  APP="Prowlarr"
  build_container
  description
  echo -e "${APP} should be reachable at http://${IP}:9696\\n"
}

function install_radarr() {
  APP="Radarr"
  build_container
  description
  echo -e "${APP} should be reachable at http://${IP}:7878\\n"
}

function install_sonarr() {
  APP="Sonarr"
  build_container
  description
  echo -e "${APP} should be reachable at http://${IP}:8989\\n"
}

# Execute Installations
install_bazarr
install_prowlarr
install_radarr
install_sonarr

echo "All services are installed successfully in a single container."
msg_ok "Completed Successfully!"

