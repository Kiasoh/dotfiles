#!/bin/bash


export DISPLAY=:1
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

echo "→ Setting GPU mode: Battery Saving (Intel only)"
sudo envycontrol -s integrated

# CPU governor to powersave
for gov in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo powersave | sudo tee "$gov" >/dev/null
done

# Powertop
if command -v powertop >/dev/null; then
    sudo powertop --auto-tune
fi

# TLP
if command -v tlp >/dev/null; then
    sudo tlp start
fi

notify-send "Battery Saving Mode Enabled"
notify-send "Restart/logout for gpu setting to take place"

