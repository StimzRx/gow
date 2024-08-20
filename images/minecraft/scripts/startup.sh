#!/bin/bash
set -e

source /opt/gow/bash-lib/utils.sh
source /opt/gow/launch-comp.sh

gow_log "Minecraft Prism Launcher startup.sh"

gow_log "Starting Prism Launcher..."

launcher /Applications/prism_launcher.AppImage --appimage-extract-and-run