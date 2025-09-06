#!/bin/bash
# Claude Code Notification Hook Script
# This script is called when Claude Code triggers a notification

# Parse JSON input from stdin
INPUT=$(cat)

# Extract message from JSON (simplified parsing)
MESSAGE=$(echo "$INPUT" | grep -o '"message":"[^"]*' | sed 's/"message":"//')

# Send notification with claude-code appname (triggers sound via dunst rule)
notify-send "Claude Code" "${MESSAGE:-Notification}" -a "claude-code" -u normal

# Also play sound directly as backup
/usr/bin/aplay ~/.config/dunst/bike-horn.wav &