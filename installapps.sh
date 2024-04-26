
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

# Common settings for the container
function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN="unifiedapp"
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

# Unified Start
start

# Installation Functions
function install_bazarr() {
  APP="Bazarr"
  build_container
  description
  echo -e "${APP} should be reachable at http://${IP}:6767\n"
}

function install_prowlarr() {
  APP="Prowlarr"
  build_container
  description
  echo -e "${APP} should be reachable at http://${IP}:9696\n"
}

function install_radarr() {
  APP="Radarr"
  build_container
  description
  echo -e "${APP} should be reachable at http://${IP}:7878\n"
}

function install_sonarr() {
  APP="Sonarr"
  build_container
  description
  echo -e "${APP} should be reachable at http://${IP}:8989\n"
}

# Execute Installations
install_bazarr
install_prowlarr
install_radarr
install_sonarr

echo -e "All services are installed successfully in a single container."
msg_ok "Completed Successfully!"
