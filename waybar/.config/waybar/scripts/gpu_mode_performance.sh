#!/bin/bash

export DISPLAY=:1
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"


echo "→ Setting GPU mode: Performance (NVIDIA only)"
sudo envycontrol -s nvidia

# Set CPU to performance mode
for gov in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo performance | sudo tee "$gov" >/dev/null
done

notify-send "Performance Mode Enabled" 
notify-send "Restart/logout for gpu setting to take place"

