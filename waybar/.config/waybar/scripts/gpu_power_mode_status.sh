#!/bin/bash

STATE_FILE="$HOME/.config/waybar/.gpu_mode_state"
MODE=$(cat "$STATE_FILE" 2>/dev/null || echo "performance")

# Detect GPU mode (envycontrol optional)
GPU=$(envycontrol --query 2>/dev/null)

# Detect CPU governor
CPU=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null || echo "unknown")

# Output JSON (Waybar requires alt to match format-icons)
jq --unbuffered --compact-output -n \
  --arg mode "$MODE" \
  --arg gpu "$GPU" \
  --arg cpu "$CPU" \
  '{ 
    "alt": ($mode), 
    "tooltip": true, 
    "gpu": ($gpu),
    "cpu": ($cpu),
    "text": "MODE: \($mode)\nGPU: \($gpu)\nCPU: \($cpu)"
  }'
